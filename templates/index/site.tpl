{**
 * templates/index/site.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library & University of Toronto Library
 * Copyright (c) 2003-2014 John Willinsky & Info. Tech. Services of University of Toronto Library
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 *}
{strip}
{if $siteTitle}
	{assign var="pageTitleTranslated" value=$siteTitle}
{/if}
{include file="common/index_header.tpl"}
{/strip}

{if $intro}<div id="intro">{$intro|nl2br}</div>{/if}

{iterate from=journals item=journal}
  <div class='index-journal'>
    
	{assign var="displayHomePageImage" value=$journal->getLocalizedSetting('homepageImage')}
	{assign var="displayHomePageLogo" value=$journal->getLocalizedPageHeaderLogo(true)}
	{assign var="displayPageHeaderLogo" value=$journal->getLocalizedPageHeaderLogo()}

	{if $site->getSetting('showThumbnail')}
		{assign var="displayJournalThumbnail" value=$journal->getLocalizedSetting('journalThumbnail')}
		{if $displayJournalThumbnail && is_array($displayJournalThumbnail)}
			{assign var="altText" value=$journal->getLocalizedSetting('journalThumbnailAltText')}
			<div class="homepageImage"><a href="{url journal=$journal->getPath()}" class="action"><img src="{$journalFilesPath}{$journal->getId()}/{$displayJournalThumbnail.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} /></a></div>
		{/if}
		{if $displayHomePageImage && is_array($displayHomePageImage)}
			{assign var="altText" value=$journal->getLocalizedSetting('homepageImageAltText')}
			<div class="homepageImage"><a href="{url journal=$journal->getPath()}" class="action"><img src="{$journalFilesPath}{$journal->getId()}/{$displayHomePageImage.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} /></a></div>
		{elseif $displayHomePageLogo && is_array($displayHomePageLogo)}
			{assign var="altText" value=$journal->getLocalizedSetting('homeHeaderLogoImageAltText')}
			<div class="homepageImage"><a href="{url journal=$journal->getPath()}" class="action"><img src="{$journalFilesPath}{$journal->getId()}/{$displayHomePageLogo.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} /></a></div>
		{elseif $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
			{assign var="altText" value=$journal->getLocalizedSetting('pageHeaderLogoImageAltText')}
			<div class="homepageImage"><a href="{url journal=$journal->getPath()}" class="action"><img src="{$journalFilesPath}{$journal->getId()}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} /></a></div>
		{/if}
	{/if}
	
	<ul class='index-journal-nav'>		
		<li><a target='_blank' href="{url journal=$journal->getPath()}" class="action">{translate key="site.journalView"}</a></li>
		<li><a target='_blank' href="{url journal=$journal->getPath() page="issue" op="current"}" class="action">{translate key="site.journalCurrent"}</a></li>
		<li><a target='_blank' href="{url journal=$journal->getPath() page="user" op="register"}" class="action">{translate key="site.journalRegister"}</a></li>
	</ul>
	
	<div class='index-journal-text'>
		{if $site->getSetting('showTitle')}
			<h1>{$journal->getLocalizedTitle()|escape}</h1>
		{/if}
		{if $site->getSetting('showDescription')}
			{if $journal->getLocalizedDescription()}
				<p>{$journal->getLocalizedDescription()|nl2br}</p>
			{/if}
		{/if}
	</div>

</div>
{/iterate}

{include file="common/index_footer.tpl"}
