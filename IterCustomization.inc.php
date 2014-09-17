<?php
/**
 * @file IterCustomization.inc.php
 * Custom code for Iter to do access check based on user IP and only apply to selected
 * journals below.
 */

// only interested in the following journals with coresponding resource_id from Iter
// @TODO: dynamic fetch this list from Iter server
$journalCodesInterested = array(
 		'renref' => 8,
 		'emw' => 20,
 		'qua' => 10,
 		'confrat' => 15,
 		'eth' => 6,
		'reed' => 7
);

//$iter_environment = 'dev';
$iter_environment = 'www';

if (isset($_SERVER['PATH_INFO'])) {
	try {
		$path_info = $_SERVER['PATH_INFO'];
		$journalCode = '';
		$sectionCode = '';
		$actionCode = '';
		
		$matches = array();
		//echo "PATH INFO: {$path_info}<br /><br />";
		
		
		if (preg_match('/\/(\w+)\/(\w+)\/(\w+)/i', $path_info, $matches) === 1) {
// 			echo '<pre>'.print_r($matches, TRUE).'</pre>';
// 			exit();
			if (isset($matches[1])) {
				// for example /eth/article/view/3/1 ----> $journalCode = 'eth';
				$journalCode = $matches[1];
			}
			
			// for example /eth/article/view/3/1 ----> $sectionCode = 'article';
			if (isset($matches[2])) {
				$sectionCode = $matches[2];
			}
			
			// for example /eth/article/viewFile/3/1 ----> $actionCode = 'viewFile';
			if (isset($matches[3])) {
				$actionCode = $matches[3];
			}
			
			if (array_key_exists($journalCode, $journalCodesInterested)
					&& $sectionCode == 'article'
					&& ($actionCode == 'view' || $actionCode == 'viewFile' || $actionCode == 'download')) {
				$user_ip = $_SERVER["REMOTE_ADDR"];
				$resource_id = isset($journalCodesInterested[$journalCode]) ? $journalCodesInterested[$journalCode]:0;
				
				if ($resource_id > 0) {
					// create curl resource
					$ch = curl_init();
					curl_setopt($ch, CURLOPT_POST, TRUE);
					//return the transfer as a string
					curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
					
					// set url
					curl_setopt($ch, CURLOPT_URL, "http://{$iter_environment}.itergateway.org/iter_ojs_log.php");
					
					if ($actionCode == 'view') { // tell iter not to count this as the page will also call viewFile
						curl_setopt($ch, CURLOPT_POSTFIELDS, "key=1dc3x&ip={$user_ip}&resource_id={$resource_id}&skipCount=true");
					} else {
						curl_setopt($ch, CURLOPT_POSTFIELDS, "key=1dc3x&ip={$user_ip}&resource_id={$resource_id}");
					}

						
					// $response contains the output string
					$response = curl_exec($ch);
						
					// close curl resource to free up system resources
					curl_close($ch);
						
					//echo $response;
						
					if (preg_match('/ERROR.*/', $response) === 1) {
						header("Location: http://{$iter_environment}.itergateway.org/login/msg=no_access_to_resource");
						exit();
					}
				}
			}
		}
	} catch (Exception $e) {
		
	}
}
