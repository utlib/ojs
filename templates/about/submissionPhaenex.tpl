{if (substr_count($currentUrl,"callforpapers")>0) }
		<style type="text/css" media="screen">@import "{$baseUrl}/public/journals/3/guidelines.css";</style>
	{elseif (substr_count($currentUrl,"guidelines")>0)}
		<style type="text/css" media="screen">@import "{$baseUrl}/public/journals/3/callforpapers.css";</style>
	{elseif (substr_count($currentUrl,"copyright")>0)}
		<style type="text/css" media="screen">@import "{$baseUrl}/public/journals/3/copyright.css";</style>
	{elseif (substr_count($currentUrl,"privacy")>0)}
		<style type="text/css" media="screen">@import "{$baseUrl}/public/journals/3/privacy.css";</style>
{elseif (substr_count($currentUrl,"onlinesubmissions")>0)}
		<style type="text/css" media="screen">@import "{$baseUrl}/public/journals/3/onlinesubmissions.css";</style>
	{/if}




{*	{$currentUrl}	*}
{if $currentJournal->getSetting('journalPaymentsEnabled') && 
		($currentJournal->getSetting('submissionFeeEnabled') || $currentJournal->getSetting('fastTrackFeeEnabled') || $currentJournal->getSetting('publicationFeeEnabled')) }
	{assign var="authorFees" value=1}
{/if}


{*
<ul class="plain">
	<li>&#187; <a href="{url page="about" op="submissions" anchor="onlineSubmissions"}">{translate key="about.onlineSubmissions"}</a></li>
	{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}<li>&#187; <a href="{url page="about" op="submissions" anchor="authorGuidelines"}">{translate key="about.authorGuidelines"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}<li>&#187; <a href="{url page="about" op="submissions" anchor="copyrightNotice"}">{translate key="about.copyrightNotice"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<li>&#187; <a href="{url page="about" op="submissions" anchor="privacyStatement"}">{translate key="about.privacyStatement"}</a></li>{/if}
	{if $authorFees}<li>&#187; <a href="{url page="about" op="submissions" anchor="authorFees"}">{translate key="about.authorFees"}</a></li>{/if}	
</ul>
*}

<ul class="plain">
	<li>&#187; <a href="{$baseUrl}/index.php/phaenex/about/submissions/onlinesubmissions">{translate key="about.onlineSubmissions"}</a></li>
	{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}<li>&#187; <a href="{$baseUrl}/index.php/phaenex/about/submissions/guidelines">{translate key="about.authorGuidelines"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}<li>&#187; <a href="{$baseUrl}/index.php/phaenex/about/submissions/copyright">{translate key="about.copyrightNotice"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<li>&#187; <a href="{$baseUrl}/index.php/phaenex/about/submissions/privacy">{translate key="about.privacyStatement"}</a></li>{/if}
	{if $authorFees}<li>&#187; <a href="{url page="about" op="submissions" anchor="authorFees"}">{translate key="about.authorFees"}</a></li>{/if}	
</ul>

{*
{if ((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/onlinesubmissions"))==0)}
*}

{if (substr_count($currentUrl,"phaenex/about/submissions/onlinesubmissions")>0)}

{*
<a name="onlineSubmissions"></a><h3>{translate key="about.onlineSubmissions"}</h3>
<p>
	{translate key="about.onlineSubmissions.haveAccount" journalTitle=$siteTitle|escape}<br />
	<a href="{url page="login"}" class="action">{translate key="about.onlineSubmissions.login"}</a>
</p>
<p>
	{translate key="about.onlineSubmissions.needAccount"}<br />
	<a href="{url page="user" op="register"}" class="action">{translate key="about.onlineSubmissions.registration"}</a>
</p>
<p>{translate key="about.onlineSubmissions.registrationRequired"}</p>
*}
{/if}  {**************************************   END OF ONLINE SUBMISSIONS  ************************************************}



{*
{if ((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/guidelines"))==0)||((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/callforpapers"))==0)||((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/onlinesubmissions"))==0)}
*}

{if (substr_count($currentUrl,"phaenex/about/submissions/guidelines")>0)||(substr_count($currentUrl,"phaenex/about/submissions/callforpapers")>0)||(substr_count($currentUrl,"phaenex/about/submissions/onlinesubmissions")>0)}

{*<div class="separator">&nbsp;</div>*}

{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
{*  <a name="authorGuidelines"></a><h3>{translate key="about.authorGuidelines"}</h3>  *}
{*<p></p>*}
{$currentJournal->getLocalizedSetting('authorGuidelines')|nl2br}

{/if}


{/if}  {**************************************   END OF AUTHOR GUIDELINES  ************************************************}


{*
{if ((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/onlinesubmissions"))==0)||((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/guidelines"))==0)}
*}
{if (substr_count($currentUrl,"phaenex/about/submissions/onlinesubmissions")>0)||(substr_count($currentUrl,"phaenex/about/submissions/guidelines")>0)}

<a name="submissionPreparationChecklist"></a><h3>{translate key="about.submissionPreparationChecklist"}</h3>
<p>{translate key="about.submissionPreparationChecklist.description"}</p>
<ol>
	{foreach from=$submissionChecklist item=checklistItem}
		<li>{$checklistItem.content|nl2br}</li>	
	{/foreach}
</ol>

{/if}	 {**************************************   END OF ONLINESUBMISSIONS  ************************************************}


{*
{if ((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/copyright"))==0)}
*}

{if (substr_count($currentUrl,"phaenex/about/submissions/copyright")>0)}

{*	<div class="separator">&nbsp;</div>	*}
<br/><br/><br/>
{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
<a name="copyrightNotice"></a><h3>{translate key="about.copyrightNotice"}</h3>

<p>{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>

{*	<div class="separator">&nbsp;</div>	*}
{/if}

{/if}	 {**************************************   END OF COPYRIGHT  ************************************************}

{*
{if ((strcasecmp ( $currentUrl,  "http://ojs.uwindsor.ca/ojs/leddy/index.php/phaenex/about/submissions/privacy"))==0)}
*}
{if (substr_count($currentUrl,"phaenex/about/submissions/privacy")>0)}

<br/><br/><br/>
{*	<div class="separator">&nbsp;</div>	*}

{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<a name="privacyStatement"></a><h3>{translate key="about.privacyStatement"}</h3>
<p>{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}</p>


{/if}

{/if}	 {**************************************   END OF PRIVACY STATEMENT  ************************************************}

{if $authorFees}

<a name="authorFees"></a><h3>{translate key="manager.payment.authorFees"}</h3>
	<p>{translate key="about.authorFeesMessage"}</p>
	{if $currentJournal->getSetting('submissionFeeEnabled')}
		<p>{$currentJournal->getLocalizedSetting('submissionFeeName')|escape}: {$currentJournal->getSetting('submissionFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('submissionFeeDescription')|nl2br}</p>
	{/if}
	{if $currentJournal->getSetting('fastTrackFeeEnabled')}
		<p>{$currentJournal->getLocalizedSetting('fastTrackFeeName')|escape}: {$currentJournal->getSetting('fastTrackFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('fastTrackFeeDescription')|nl2br}</p>	
	{/if}
	{if $currentJournal->getSetting('publicationFeeEnabled')}
		<p>{$currentJournal->getLocalizedSetting('publicationFeeName')|escape}: {$currentJournal->getSetting('publicationFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('publicationFeeDescription')|nl2br}</p>	
	{/if}
	{if $currentJournal->getLocalizedSetting('waiverPolicy') != ''}
		<p>{$currentJournal->getLocalizedSetting('waiverPolicy')|escape}</p>
	{/if}
{/if} 