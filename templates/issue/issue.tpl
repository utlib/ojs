{**
 * templates/issue/issue.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Issue
 *
 *}
{foreach name=sections from=$publishedArticles item=section key=sectionId}
{if $section.title}
{************************    START OF -- CELT SectionTitle Tweaks -- 	***********************}
{if ((strcasecmp ( $siteTitle,  "Collected Essays on Learning and Teaching"))==0)}
{if ((strcasecmp ( $issueHeadingTitle,  "Vol 1 (2008)"))==0)}
	{if ((strcasecmp ( $section.title,  "Section I:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Preparing to Teach</h4><br/>
	{/if}	
	{if ((strcasecmp ( $section.title,  "Section II:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} In The Classroom</h4><br/>
	{/if}	
	{if ((strcasecmp ( $section.title,  "Section III:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Assessment</h4><br/>
	{/if}
{elseif ((strcasecmp ( $issueHeadingTitle,  "Vol 2 (2009)"))==0)}
	{if ((strcasecmp ( $section.title,  "Section I:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Preparing to Teach in a Diverse World of Learning</h4><br/>
	{/if}	
	{if ((strcasecmp ( $section.title,  "Section II:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Enhancing Practice in a World of Learning</h4><br/>
	{/if}	
	{if ((strcasecmp ( $section.title,  "Section III:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Assessment, Evaluation, & Reflecting in a World of Learning</h4><br/>
	{/if}
{elseif ((strcasecmp ( $issueHeadingTitle,  "Vol 3 (2010)"))==0)}
	{if ((strcasecmp ( $section.title,  "Section I:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Practice and Engagement</h4><br/>
	{/if}	
	{if ((strcasecmp ( $section.title,  "Section II:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Identity and Community</h4><br/>
	{/if}	
	{if ((strcasecmp ( $section.title,  "Section III:"))==0)}
		<h4 class="tocSectionTitle">{$section.title|escape} Development and Transitions</h4><br/>
	{/if}
{else}
<h4 class="tocSectionTitle">{$section.title|escape}</h4>
{/if}

{else}
<h4 class="tocSectionTitle">{$section.title|escape}</h4>
{/if}{************************    END OF -- CELT SectionTitle Tweaks -- 	***********************}
{/if}

{foreach from=$section.articles item=article}
	{assign var=articlePath value=$article->getBestArticleId($currentJournal)}

<table class="tocArticle" width="100%">
<tr valign="top">
	{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
	<td rowspan="2">
		<div class="tocArticleCoverImage">
		<a href="{url page="article" op="view" path=$articlePath}" class="file">
		<img src="{$coverPagePath|escape}{$article->getFileName($locale)|escape}"{if $article->getCoverPageAltText($locale) != ''} alt="{$article->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}/></a></div>
	</td>
	{/if}
	{call_hook name="Templates::Issue::Issue::ArticleCoverImage"}

	{if $article->getLocalizedAbstract() == ""}
		{assign var=hasAbstract value=0}
	{else}
		{assign var=hasAbstract value=1}
	{/if}

	{assign var=articleId value=$article->getId()}
	{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial && $articleExpiryPartial.$articleId))}
		{assign var=hasAccess value=1}
	{else}
		{assign var=hasAccess value=0}
	{/if}

	<td class="tocTitle">{if !$hasAccess || $hasAbstract}<a href="{url page="article" op="view" path=$articlePath}">{$article->getLocalizedTitle()|strip_unsafe_html}</a>{else}{$article->getLocalizedTitle()|strip_unsafe_html}{/if}</td>
	<td class="tocGalleys">
		{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
			{foreach from=$article->getGalleys() item=galley name=galleyList}
				<a href="{url page="article" op="view" path=$articlePath|to_array:$galley->getBestGalleyId($currentJournal)}" {if $galley->getRemoteURL()}target="_blank" {/if}class="file">{$galley->getGalleyLabel()|escape}</a>
				{if $subscriptionRequired && $showGalleyLinks && $restrictOnlyPdf}
					{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || !$galley->isPdfGalley()}
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
					{else}
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
					{/if}
				{/if}
			{/foreach}
			{if $subscriptionRequired && $showGalleyLinks && !$restrictOnlyPdf}
				{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
				{else}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
				{/if}
			{/if}
		{/if}
	</td>
</tr>
<tr>
	<td class="tocAuthors">
		{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
			{foreach from=$article->getAuthors() item=author name=authorList}
				{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
			{/foreach}
		{else}
			&nbsp;
		{/if}
	</td>
	<td class="tocPages">{$article->getPages()|escape}</td>
</tr>
</table>
{call_hook name="Templates::Issue::Issue::Article"}
{/foreach}

{if !$smarty.foreach.sections.last}
<div class="separator"></div>
{/if}
{/foreach}

