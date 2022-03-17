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
declare variable $circumf := 2 * $pi * $radius;
declare variable $total := $btrees/Q{}entry => count();

declare variable $Secure := $btrees//Q{}entry[Q{}status ! replace(text() , ' ','') =  "Secure"]=>count();
declare variable $Undefined := $btrees//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') ="Undefined"]=>count();
declare variable $ApparentlySecure := $btrees//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') ="ApparentlySecure"]=>count();
declare variable $Imperiled := $btrees//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') ="Imperiled"]=>count();
declare variable $PossiblyExtinct := $btrees//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') ="PossiblyExtinct"]=>count();
declare variable $Vulnerable := $btrees//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') ="Vulnerable"]=>count();
declare variable $CriticallyImperiled  := $btrees//Q{}entry[Q{}status ! text() ! replace(. , ' ', '') ="CriticallyImperiled"]=>count();

declare variable $p_Secure := $Secure div $total;
declare variable $p_Undefined := $Undefined div  $total;
declare variable $p_ApparentlySecure := $ApparentlySecure div $total;
declare variable $p_Imperiled := $Imperiled div $total;
declare variable $p_PossiblyExtinct := $PossiblyExtinct div $total;
declare variable $p_Vulnerable := $Vulnerable div $total;
declare variable $p_CriticallyImperiled  := $CriticallyImperiled div $total;



<svg width="100%" height="100%" style="background-color:lightgrey" viewBox="0 0 1000 1000">
<g transform="translate(50, 500)">
    <g transform = "translate(210)">
        <rect x="0" y="-15" width="20" height="20" fill="{$c_DOGreen}"/>
        <text x="30" y="0" fill="black"></text>
        <rect x="150" y="-15" width="20" height="20" fill="{$c_Green}"/>
        <text x="180" y="0" fill="black"></text>
    </g>
{

   
    
<g class="tree" transform="translate(200,0)">
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled + $p_PossiblyExtinct + $p_Vulnerable + $p_CriticallyImperiled), $circumf}" stroke="red"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled + $p_PossiblyExtinct + $p_Vulnerable), $circumf}" stroke="orange"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled + $p_PossiblyExtinct), $circumf}" stroke="yellow"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($p_Secure  + $p_Undefined  +  $p_ApparentlySecure  + $p_Imperiled), $circumf}" stroke="{$c_Green}"/>

    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($p_Secure  + $p_Undefined  +  $p_ApparentlySecure), $circumf}" stroke="blue"/>

    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($p_Secure  + $p_Undefined), $circumf}" stroke="purple"/>
 
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($p_Secure), $circumf}" stroke="pink"/>
 
</g>
}
</g>
</svg>

