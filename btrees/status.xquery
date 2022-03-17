xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg";
declare namespace math = "http://www.w3.org/2005/xpath-functions/math";
declare variable $btrees := doc('Master-Tree-Info/Master_Tree_Book.xml')/*;
declare variable $maxHeight := $btrees//Q{}height/@avg => max();
declare variable $minHeight := $btrees//Q{}height/@avg => min();
declare variable $xSpace := 4;
declare variable $ySpace := 35;
declare variable $countEntries := $btrees//Q{}entry => count();


declare variable $c_DOGreen := "#556B2F";
declare variable $c_Green :=  "#008000";

declare variable $c_YGreen := "#9ACD32";
declare variable $c_DGreen := "#006400";
declare variable $c_OliveDrab := "#6B8E23";
declare variable $c_SeaGreen := "#2E8B57";
declare variable $c_DSGrey := "#2F4F4F";

declare variable $radius := 200;
declare variable $pi := math:pi();
declare variable $circumf := 2 * math:pi() * $radius";

declare variable $total := $btrees/Q{}entry => count();

declare variable $Secure := $btree//Q{}entry[Q{}status ! text() ! replace(. , ' ','') =Q{} "Secure"]=>count();
declare variable $Undefined := $btree//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') =Q{}"Undefined"]=>count();
declare variable $ApparentlySecure := $btree//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') =Q{}"ApparentlySecure"]=>count();
declare variable $Imperiled := $btree//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') =Q{}"Imperiled"]=>count();
declare variable $PossiblyExtinct := $btree//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') =Q{}"PossiblyExtinct"]=>count();
declare variable $Vulnerable := $btree//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') =Q{}"Vulnerable"]=>count();
declare variable $CriticallyImperiled  := $btree//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') =Q{}"CriticallyImperiled"]=>count();

declare variable $p_Secure := $total div $Secure;
declare variable $p_Undefined := $total div $Undefined;
declare variable $p_ApparentlySecure := $total div $ApparentlySecure;
declare variable $p_Imperiled := $total div $Imperiled;
declare variable $p_PossiblyExtinct := $total div $PossiblyExtinct;
declare variable $p_Vulnerable := $total div $Vulnerable;
declare variable $p_CriticallyImperiled  := $total div $CriticallyImperiled;



<svg width="{$xSpace * $maxHeight + 300}" height="{$countEntries * $ySpace + 200}" style="background-color:lightgrey">
<g transform="translate(50, 50)">
    <g transform = "translate(210)">
        <rect x="0" y="-15" width="20" height="20" fill="{$c_DOGreen}"/>
        <text x="30" y="0" fill="black"></text>
        <rect x="150" y="-15" width="20" height="20" fill="{$c_Green}"/>
        <text x="180" y="0" fill="black"></text>
    </g>
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

let $status := $s/Q{}status ! replace(. , ' ', '')
let $status_color := if($status = "Secure") then $c_DGreen else if($status = "Undefined") then $c_DOGreen
    else if($status = "ApparentlySecure") then $c_DSGrey else if ($status = "Imperiled") then $c_Green
    else if($status = "PossiblyExtinct") then $c_OliveDrab else if ($status = "Vulnerable") then $c_SeaGreen
    else $c_YGreen

return
   
    
<g class="tree" id="position-{$pos}" transform="translate(200,0)">
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled + $p_PossiblyExtinct + $p_Vulnerable + $CriticallyImperiled), $circumf}" stroke="{$c_DGreen}"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled + $p_PossiblyExtinct + $p_Vulnerable), $circumf}" stroke="{c_DOGreen}"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled + $p_PossiblyExtinct), $circumf}" stroke="{$c_DSGrey}"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled), $circumf}" stroke="{$c_Green}"/>

    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$p_Secure  + $p_Undefined  +  $p_ApparentlySecure), $circumf}" stroke="{$c_OliveDrab}"/>

    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$p_Secure  + $p_Undefined), $circumf}" stroke="{$c_SeaGreen}"/>
 
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$p_Secure), $circumf}" stroke="{$c_YGreen}"/>
 
</g>
}
</g>
</svg>

