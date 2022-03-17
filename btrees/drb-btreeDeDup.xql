xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg";
declare variable $btrees := doc('Master-Tree-Info/Master_Tree_Book.xml')/*;
declare variable $maxHeight := $btrees//Q{}height/@avg => max();
declare variable $minHeight := $btrees//Q{}height/@avg => min();
declare variable $xSpace := 4;
declare variable $ySpace := 35;
declare variable $countEntries := $btrees//Q{}entry => count();



declare variable $DOGreen := "#556B2F";
declare variable $YGreen := "#9ACD32";
declare variable $Green :=  "#008000";


<svg width="{$xSpace * $maxHeight + 300}" height="{$countEntries * $ySpace + 200}" style="background-color:lightgrey">
<g transform="translate(50, 50)">
{
let $entries := 
       let $allEntries := $btrees/Q{}entry[Q{}cname = Q{}cname ! string() ! replace(.,' \d','')]
       let $cnames := $allEntries/Q{}cname
       let $distinctCNs := $cnames => distinct-values()
       for $d in $distinctCNs
            let $entryMatch := $allEntries[Q{}cname = $d][1]
            return $entryMatch
    

let $sortedEntries := 

       for $e in $entries
       let $height := $e/Q{}height/@avg ! number(.)
       order by $height descending
       return $e
       
(: Let us write a for-loop over the entries :)

for $s at $pos in $sortedEntries
let $cname := $s/Q{}cname ! text() ! replace(. , ' \d', '')
let $height := $s/Q{}height/@avg ! number(.)

let $treeType := $s/Q{}treeType
let $treeType_color := if($treeType = "Deciduous") then $DOGreen else $Green
return
   
    
<g class="tree" id="position-{$pos}" transform="translate(200,0)">
    
    <line id="{$cname}" x1="0" x2="{$height * $xSpace}" y1="{$pos * $ySpace}" y2="{$pos * $ySpace}" 
    stroke-width="{$ySpace*0.9}" stroke="{$treeType_color}" transform="translate(10,-6)"/> 
    
    <text x="0" y="{$pos * $ySpace}" fill="black" style="text-anchor:end">{$cname}</text>
    
    <text x="{$height * $xSpace}" y="{$pos * $ySpace}" fill="lightgreen" style="text-anchor:end" transform="translate(4,0)">{$height}</text>
</g>
}
</g>
</svg>

