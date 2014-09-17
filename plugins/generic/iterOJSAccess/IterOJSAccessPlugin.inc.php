<?php
import('lib.pkp.classes.plugins.GenericPlugin');
class IterOJSAccessPlugin extends GenericPlugin {
	//private $iter_environment = 'dev';
	private $iter_environment = 'www';
	
	// for translating journals to Iter Resource IDs
	private $journalCodesInterested = array(
	 		'renref' => 8,
	 		'emw' => 20,
	 		'qua' => 10,
	 		'confrat' => 15,
			'eth' => 6,
			'reed' => 7
	);
	
	// registering the hooks
    function register($category, $path) {
		$success = parent::register($category, $path);
		if ($success && $this->getEnabled()) {
			
			HookRegistry::register ('LoadHandler', array(&$this, 'handleRequest'));
			
			// Hook to be called after OJS has determined whether or not a subscription is required for viewing the journal issue
			HookRegistry::register ('IssueAction::subscriptionRequired', array(&$this, 'handleSubscriptionRequired'));
			
			HookRegistry::register ('TemplateManager::display', array(&$this, 'handleTemplateDisplay'));
		}
		return $success;
	}
	
	// mandatory function
    function getName() { 
        return 'IterOJSAccess'; 
    }
    
    // mandatory function
    function getDisplayName() { 
        return 'Iter OJS Access'; 
    }
    
    // mandatory function
    function getDescription() { 
        return 'Iter OJS Access plugin controls journal access according to Iter user database'; 
    }
	
	function isSitePlugin() {
		return FALSE;
	}
	

	
	function handleRequest($hookName, $args) {
		//header('Location: http://library.utoronto.ca');
		$page =& $args[0];
		$op =& $args[1];
		$sourceFile =& $args[2];
		
		if ($page == 'article') { // only interested in article views or downloads
			if ($op == 'view' || $op == 'download') { // we do not care $op == 'viewFile' as it's called within view page to embed PDF
				
				// only do the count if the request path is of the form ****/article/view/x/y or ****/article/download/x/y where x,y are numbers
				// we do not count on path like ***/article/x because it's an abstract of the issue, not the full text
				$matches = array();
				if (preg_match('/\w*\/(view|download)\/[0-9]+\/[0-9]+/i', Request::getRequestPath(), $matches) === 1) {
					//echo '<pre>'.print_r($matches, TRUE).'</pre>';
					$journal = Request::getJournal();
					
					$journal_abbrev = $journal->_data['path'];
					
					$user_ip = $_SERVER['REMOTE_ADDR'];
					// Whether or not with delayed open access, if user is Iter subscriber, let them view
					$iterResourceId = isset($this->journalCodesInterested[$journal_abbrev]) ? $this->journalCodesInterested[$journal_abbrev]:0;
					
					$this->isIterSubscriber($user_ip, $iterResourceId, FALSE); // increment the stats count
				}
			}
		}
	
		return FALSE;
	}
	
	/**
	 * Implementing hook IssueAction::subscriptionRequired
	 * Called after OJS has determined whether or not subscription is required for viewing $issue in $journal
	 * but before the true/false value &$result is returned
	 */
	function handleSubscriptionRequired($hookName, $args) {
		$journal =& $args[0];
		$issue =& $args[1];
		$result =& $args[2];
		
		
		// only do the check if the request path is of the form ****/article/view/x/y or ****/article/download/x/y where x,y are numbers
		// we do not check on path like ***/article/x because it's an abstract of the issue, not the full text
		$matches = array();
		
			$journal_abbrev = $journal->_data['path'];
			
			$user_ip = $_SERVER['REMOTE_ADDR'];
			// Whether or not with delayed open access, if user is Iter subscriber, let them view
			$iterResourceId = isset($this->journalCodesInterested[$journal_abbrev]) ? $this->journalCodesInterested[$journal_abbrev]:0;
			
			$isIterSubscriber = $this->isIterSubscriber($user_ip, $iterResourceId, TRUE); // We are only checking for access, do not do stats count
			//echo '<span style="display:none;">Iter Subscriber: '. ($isIterSubscriber? 'yes':'no').'</span>';
			//return true;
			if ($isIterSubscriber) {
				$result = FALSE; // mark as subscription NOT required in OJS
				return TRUE; // return TRUE to let OJS know it's been taken care of
			} else {
				if (isset($issue->_data['accessStatus']) && $issue->_data['accessStatus'] == 2) { // non-open access issue
					$redirectToIterLogin = FALSE;
			
					if (isset($issue->_data['openAccessDate']) && $issue->_data['openAccessDate'] != '') {
						// subscription only, but with delayed open access
						$openAccessDate = new DateTime($issue->_data['openAccessDate']);
							
						if (new DateTime() > $openAccessDate) { // non-subscriber, already-opened
							// now you can access it
							return FALSE; // don't handle
						} else { // non-subscriber, non-open
							$redirectToIterLogin = TRUE;
						}
					} else {
						$redirectToIterLogin = TRUE;
					}
			
					if ($redirectToIterLogin) {
						if (preg_match('/\w*\/(view|download)\/[0-9]+\/[0-9]+/i', Request::getRequestPath(), $matches) === 1) {
							Request::redirectUrl('http://www.itergateway.org/login');
							return TRUE;
						}
					}
				}
			}
		
		
		return FALSE;  // we do not handle the hook for non-iter subscribers
	}
	
	
	// Make an http request to iter to determine if we can grant access to the resource
	function isIterSubscriber($ip, $iterResourceId, $skipCount = TRUE) {
		$rtval = FALSE;
		
		if ($iterResourceId > 0) {
			// create curl resource
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_POST, TRUE);
			//return the transfer as a string
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				
			// set url
			curl_setopt($ch, CURLOPT_URL, "http://{$this->iter_environment}.itergateway.org/iter_ojs_log.php");
				
			if ($skipCount) {
				curl_setopt($ch, CURLOPT_POSTFIELDS, "key=1dc3x&ip={$ip}&resource_id={$iterResourceId}&skipCount=true");
			} else {
				curl_setopt($ch, CURLOPT_POSTFIELDS, "key=1dc3x&ip={$ip}&resource_id={$iterResourceId}");
			}
		
			// $response contains the output string
			$response = curl_exec($ch);
		
			// close curl resource to free up system resources
			curl_close($ch);
		
			if (preg_match('/ERROR.*/', $response) === 1) {
				$rtval = FALSE;
			} else {
				$rtval = TRUE;
			}
		}
		
		return $rtval;
	}
	
	
	function handleTemplateDisplay($hookName, $args) {
		$templateMgr =& $args[0];
		$template =& $args[1];
		$sendContentType =& $args[2];
		$charset =& $args[3];
		
		
		//echo '<pre>'.print_r($templateMgr, TRUE).'</pre>';
		switch ($template) {
			case 'article/article.tpl':
				$templateMgr->display(PKPPlugin::getTemplatePath() . 'article.tpl');
				return TRUE;
				break;
		}
		
		return FALSE;
	}
} 
?>
