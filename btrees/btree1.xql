xquery version "3.1";
declare variable $btrees := doc('Master-Tree-Info/Master_Tree_Book.xml')/*;
declare variable $maxHeight := $btrees//height/@avg => max();
declare variable $minHeight := $btrees//height/@avg => min();
declare variable $xSpace := 4;
declare variable $ySpace := 40;
declare variable $countEntries := $btrees//entry => count();


<svg width="{$xSpace * $maxHeight + 300}" height="{$countEntries * $ySpace + 200}" style="background-color:lightgrey">
<g transform="translate(50, 50)">
{
let $entries := $btrees/entry[cname = cname ! string() ! replace(.,' \d','')][not(cname = preceding-sibling::entry/cname)]
let $sortedEntries := 
       for $e in $entries
       let $height := $e/height/@avg ! number(.)
       order by $height descending
       return $e
       
(: Let us write a for-loop over the entries :)

for $s at $pos in $sortedEntries
let $cname := $s/cname ! text() ! replace(. , ' \d', '')
let $height := $s/height/@avg ! number(.)
return
   
    
<g class="tree" id="position-{$pos}" transform="translate(200,0)">
    
    <line id="{$cname}" x1="0" x2="{$height * $xSpace}" y1="{$pos * $ySpace}" y2="{$pos * $ySpace}" 
    stroke-width="{$ySpace*0.9}" stroke="green" transform="translate(10,-6)"/> 
    
    <text x="0" y="{$pos * $ySpace}" fill="black" style="text-anchor:end">{$cname}</text>
    
    <text x="{$height * $xSpace}" y="{$pos * $ySpace}" fill="lightgreen" style="text-anchor:end" transform="translate(4,0)">{$height}</text>
</g>
}
</g>
</svg>
