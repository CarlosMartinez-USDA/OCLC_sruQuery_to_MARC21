<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" xmlns="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd xlink">
    
 
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 19, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b>Carlos Martinez III</xd:p>
            <xd:p>Recreated for SRU Query tranform during 2020</xd:p>
        </xd:desc>
        <xd:desc name="global_parameters" scope="component">
            <xd:ul>
                <xd:li><xd:em>archiveFile:</xd:em> Filename of the current document-node(xml or zip); originally holds the source metadata.</xd:li>
                <xd:li><xd:em>originalFilename:</xd:em>Name of the file currently being processed.</xd:li>
                <xd:li><xd:em>workingDir:</xd:em> Name of the directory containing the file currently being processed.</xd:li>
            </xd:ul>
        </xd:desc>
    </xd:doc>
    <xsl:param name="archiveFile" select="tokenize(base-uri(),'/')[last()]" />
    <xsl:param name="originalFilename" select="replace($archiveFile,'(.\w*)(\.xml)','$1')"/>
    <xsl:param name="workingDir" select="substring-before(base-uri(), ($originalFilename))"/>
</xsl:stylesheet>