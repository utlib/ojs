{**
 * templates/index/journal.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}
{if ((strcasecmp ( $siteTitle,  "phaenex"))==0)} {************************  PHAENEX CODE   *****************************}
	{if (substr_count($currentUrl,"francais")>0) }
		<style type="text/css" media="screen">@import "{$baseUrl}/public/journals/3/english.css";</style>
	{else}
		<style type="text/css" media="screen">@import "{$baseUrl}/public/journals/3/francais.css";</style>
	{/if}
{/if}{************************  END OF PHAENEX CODE   *****************************}
{if $journalDescription}
	<div id="journalDescription">{$journalDescription}</div>
{/if}

{call_hook name="Templates::Index::journal"}

{if $homepageImage}
<br />
<div id="homepageImage"><img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" width="{$homepageImage.width|escape}" height="{$homepageImage.height|escape}" {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} /></div>
{/if}

{if $additionalHomeContent}
<br />
<div id="additionalHomeContent">{$additionalHomeContent}</div>
{/if}

{if $enableAnnouncementsHomepage}
	{* Display announcements *}
	<div id="announcementsHome">
		<h3>{translate key="announcement.announcementsHome"}</h3>
		{include file="announcement/list.tpl"}	
		<table class="announcementsMore">
			<tr>
				<td><a href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a></td>
			</tr>
		</table>
	</div>
{/if}

{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	{* Display the table of contents or cover page of the current issue. *}
	<br />
	<h3>{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</h3>
	{include file="issue/view.tpl"}
{/if}
{if ((strcasecmp ( $siteTitle,  "Informal Logic"))==0)}  {************************ INFORMAL LOGIC CODE  *******************************}

<div id="dottedborder"></div>
<br/><br/><br/>
<table cellspacing="20">
<tr> 
<td valign="top" colspan="6" >
<b><font color="red">Editors</font></b>
<br/><br/>
J. Anthony Blair<br/>
Ralph H. Johnson<br/>
Hans V. Hansen<br/>
Christopher W. Tindale<br/>
<br/>
University of Windsor
<br/>
</td>
<td valign="top" width="70" >
</td>
<td valign="top" >
<font color="red"><b>Editorial Board</b></font>
<br/>
<br/>
Derek Allen,  University of Toronto<br/>
Ruth Amossy,  Tel-Aviv University<br/>
Richard Andrews,  University of London<br/>
Sharon Bailin,  Simon Fraser University<br/>
Mark Battersby,  Capilano University<br/>
Frans H. van Eemeren,  University of Amsterdam<br/>
Robert Ennis,  University of Illinois at Urbana-Champaign<br/>
Maurice Finocchiaro,  University of Nevada at Las Vegas<br/>
James B. Freeman.  City University of New York, Hunter College<br/>
Tim van Gelder,  University of Melbourne & Austhink<br/>
Michael A. Gilbert,  York University<br/>
Geoff Goddu,  University of Richmond<br/>
Jean Goodwin,  Iowa State University<br/>
Trudy Govier,  University of Lethbridge<br/>
Leo Groarke,  University of Windsor<br/>
Dale Hample,   University of Maryland<br/>
David Hitchcock	,  McMaster University<br/>
Sally Jackson,  University of Illinois at Urbana-Champaign<br/>
Fred A. Kauffeld,  Edgewood College<br/>
Christian Kock,  University of Copenhagen<br/>
Erik C.W. Krabbe,  University of Groningen<br/>
Tone Kvernbekk,  University of Oslo<br/>
Christoph Lumer,  University of Siena<br/>
Robert C. Pinto,  University of Windsor<br/>
Chris Reed,  University of Dundee<br/>
Michael Scriven, Claremont Graduate University<br/>
Harvey Siegel,  University of Miami<br/>
Francisca Snoeck Henkemans,  University of Amsterdam<br/>	
Douglas Walton	,  University of Windsor<br/>
John Woods,  University of British Columbia & King's College London<br/>
Larry Wright,  University of California at Riverside<br/>
David Zarefsky,  Northwestern University<br/>

<br/>
<br/>
<br/>
</td>
</tr>
</table>
{/if}  {************************ END OF INFORMAL LOGIC CODE  *******************************}

{include file="common/footer.tpl"}

