<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.loc.gov/MARC21/slim"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://functions/" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:zs="http://www.loc.gov/zing/srw/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:oclcterms="http://purl.org/oclc/terms/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:diag="http://www.loc.gov/zing/srw/diagnostic/"
    xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/MARC21/slim/mods-3-7.xsd"
    exclude-result-prefixes="dc diag oclcterms zs f xd xsi xs" version="2.0">
    
    
    <xsl:strip-space elements="*"/>
    
    <xsl:output name="originalFile" method="xml" indent="yes" encoding="UTF-8" media-type="text/xml" version="1.0"/>   
    <xsl:output name="archiveFile" method="xml" indent="yes" encoding="UTF-8" media-type="text/xml" version="1.0"/> 
    
    
    <xsl:include href="commons/common.xsl"/>
    <xsl:include href="commons/params.xsl"/>
   
    
    <xd:doc scope="stylesheet" id="OCLC_SRU">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 12, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Carlos.Martinez</xd:p>
            <xd:p><xd:b>Purpose:</xd:b>
                <xd:ul>           
                    <xd:li>To remove the "zing" (or zs) prefixed elements and create individual MARC records</xd:li>
                    <xd:li>The archiveFile records produced from this transformation are direct copies of all the elements within the MARC namespace; beginning with record.</xd:li>
                   <xd:li>The originalFile records produced add the marc prefix to each element making it easier to transform into other formats including MARC21 and MODS</xd:li>
                </xd:ul>
            </xd:p>
        </xd:desc>
    </xd:doc>
    
    <xd:doc>
        <xd:desc>MARC namespace template to add prefixes to elements in n-file transformation</xd:desc>
    </xd:doc>
    <xsl:template match="//marc:*" xpath-default-namespace="http://www.loc.gov/MARC21/slim">
        <xsl:element name="marc:{name()}">
            <xsl:copy-of select="namespace::*"/>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:element>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>sru template </xd:desc>
    </xd:doc>
    <xsl:template match="zs:name" xpath-default-namespace="http://www.loc.gov/zing/srw/"/>
    
    <xd:doc>
        <xd:desc>root template</xd:desc>      
    </xd:doc>
    <xsl:template match="/" xpath-default-namespace="http://www.loc.gov/MARC21/slim">  
        <zs:searchRetrieveResponse xmlns:zs="http://www.loc.gov/zing/srw/">
            <modsCollection>
                <xsl:for-each select="*//record" xpath-default-namespace="http://www.loc.gov/MARC21/slim">                   
                    <zs:records>
                        <xsl:result-document encoding="UTF-8" indent="yes" method="xml"
                            media-type="text/xml" format="archiveFile"
                            href="{$workingDir}A-{$originalFilename}_{position()}.xml">
                            <xsl:copy-of select="."/>
                        </xsl:result-document>
                    </zs:records>
                    <xsl:result-document encoding="UTF-8" indent="yes" method="xml"
                        media-type="text/xml" format="originalFile" 
                        href="{$workingDir}N-{$originalFilename}_{position()}.xml">
                        <marc:record>
                            <xsl:namespace name="marc" select="'http://www.loc.gov/MARC21/slim'"/> 
                            <xsl:namespace name="oclcterms" select="'http://purl.org/oclc/terms/'"/>
                            <xsl:namespace name="dc" select="'http://purl.org/dc/elements/1.1/'"/>
                            <xsl:namespace name="diag" select="'http://www.loc.gov/zing/srw/diagnostic/'"/>
                            <xsl:namespace name="zs" select="'http://www.loc.gov/zing/srw/'"/>
                            <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
                            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
                            <xsl:attribute name="xsi:schemaLocation" select="'http://www.loc.gov/MARC21/slim https://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd'"/>
                            <xsl:apply-templates select="marc:leader"/>
                            <xsl:apply-templates select="marc:controlfield"/>
                            <xsl:apply-templates select="marc:datafield"/>
                        </marc:record>
                    </xsl:result-document>
                </xsl:for-each>
            </modsCollection>
        </zs:searchRetrieveResponse>
    </xsl:template>
</xsl:stylesheet>