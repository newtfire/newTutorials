<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
    name="zoomTranscriptTransform">
    <p:input port="origin" primary="true" sequence="true" content-types="xml">
        <!-- @sequence="true" is for the port to take zero or more documents. -->
        <p:inline><!-- This declares a document inline. -->
            <xml>
                <section num="1">
                <timestamp>
                    <start hour="00" minute="00" second="03190"/>
                    <end hour="00" minute="00" second="07330"/>
                </timestamp>
                <transcript>Greetings digit 210. So at the end of class </transcript>
            </section>
            <section num="2">
                <timestamp>
                    <start hour="00" minute="00" second="07330"/>
                    <end hour="00" minute="00" second="10510"/>
                </timestamp>
                <transcript>today on Friday January 30th I left us on a </transcript>
            </section></xml>
        </p:inline>
    </p:input>
    
    <p:input port="insertCodes" sequence="true">
        <!-- ebb: Remember, @sequence="true" allows a sequence of zero or more. -->
        <p:inline>
            <label>metadata for section 1</label>
        </p:inline>
        <p:inline>
            <label>metadata for section 2</label>
        </p:inline>
    </p:input>
    <p:output port="result"/>
    <p:insert match="/xml/section" position="first-child">
        <p:with-input port="insertion" pipe="insertCodes@zoomTranscriptTransform"/>
    </p:insert>
    <!--<p:add-attribute match="timestamp" attribute-name="seq">
        <p:with-option name="attribute-value" select="ancestor::section/@num"/>
    </p:add-attribute>-->
    <p:viewport match="timestamp">
        <p:add-attribute match="timestamp" attribute-name="seq"
            attribute-value="{p:iteration-position()}"/>
        <!-- ebb: Noting that XPath expressions don't seem to work to define @attribute-value when
        adding an attribute. -->
    </p:viewport>
    
  
    
    
</p:declare-step>