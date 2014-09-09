{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
{strip}
{if $pageFooter==''}
	{if $currentJournal && $currentJournal->getSetting('onlineIssn')}
		{assign var=issn value=$currentJournal->getSetting('onlineIssn')}
	{elseif $currentJournal && $currentJournal->getSetting('printIssn')}
		{assign var=issn value=$currentJournal->getSetting('printIssn')}
	{/if}
	{if $issn}
		{translate|assign:"issnText" key="journal.issn"}
		{assign var=pageFooter value="$issnText: $issn"}
	{/if}
{/if}


{include file="core:common/footer.tpl"}
<div id="UofTfooter" style="margin: 0 auto; width: 100%; padding-left: 10%;">
  {if !$currentJournal}
    <img src="{$baseUrl}/templates/images/footer_white_bar.png" width="900" border="0" alt="" usemap="#lin" />
    <map name="lin">
    <area shape="rect" coords="494,9,891,95" href="http://www.library.utoronto.ca" alt=""/>
    </map>
  {/if}
</div><!-- UofTfooter -->
{/strip}

