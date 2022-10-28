<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:TEI="http://www.tei-c.org/ns/1.0"
    xmlns:zs="http://www.loc.gov/zing/srw/" xmlns:marc="http://www.loc.gov/MARC21/slim"
    xsi:schemaLocation="http://www.tei-c.org/ns/1.0 http://www.dlib.indiana.edu/lib/xml/brevier/brevier.xsd"
    exclude-result-prefixes="TEI">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="TEI:TEI">
        <xsl:apply-templates select="TEI:teiHeader"/>
    </xsl:template>

    <!-- read in repository identifier -->
    <xsl:param name="repository"/>

    <!-- read in file name for subject headings -->
    <xsl:param name="MARCxml"/>

    <xsl:variable name="collectionid">
        <xsl:value-of select="TEI:TEI/@xml:id"/>
    </xsl:variable>

    <xsl:template match="TEI:teiHeader">
        <mods:mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:mods="http://www.loc.gov/mods/v3"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd"
            version="3.4">
            <xsl:call-template name="titleInfo"/>
            <xsl:call-template name="name"/>
            <xsl:call-template name="typeOfResource"/>
            <xsl:call-template name="originInfo"/>
            <xsl:call-template name="language"/>
            <xsl:call-template name="physicalDescription"/>
            <xsl:call-template name="subjects"/>
            <xsl:call-template name="relatedItem"/>
            <xsl:call-template name="identifier"/>
            <xsl:call-template name="location"/>
            <xsl:call-template name="accessCondition"/>
            <xsl:call-template name="recordInfo"/>
        </mods:mods>
    </xsl:template>

    <xsl:template name="titleInfo">
        <mods:titleInfo>
            <mods:title>
                <xsl:value-of
                    select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:title"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of
                    select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:biblScope[@type='volume']"
                />
            </mods:title>
        </mods:titleInfo>
    </xsl:template>

    <xsl:template name="name">
        <xsl:for-each select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:respStmt">
            <xsl:if test="./TEI:name">
                <mods:name>
                    <mods:namePart>
                        <xsl:value-of select="./TEI:name"/>
                    </mods:namePart>
                    <xsl:if test="./TEI:resp">

                        <xsl:if test="TEI:resp='Transcribed by'">
                            <mods:role>
                                <mods:roleTerm type="text">transcriber</mods:roleTerm>
                            </mods:role>
                        </xsl:if>

                    </xsl:if>
                </mods:name>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="typeOfResource">
        <!-- update to get from component if present -->
        <mods:typeOfResource>text</mods:typeOfResource>
    </xsl:template>

    <xsl:template name="originInfo">
        <mods:originInfo>
            <xsl:call-template name="publisher"/>
            <xsl:call-template name="dateCreated"/>
            <xsl:call-template name="issuance"/>
            <xsl:call-template name="placeTerm"/>
        </mods:originInfo>
    </xsl:template>

    <xsl:template name="language">
        <xsl:if test="TEI:profileDesc/TEI:langUsage/TEI:language/@ident">
            <mods:language>
                <mods:languageTerm type="code" authority="rfc3066">
                    <xsl:value-of select="TEI:profileDesc/TEI:langUsage/TEI:language/@ident"/>
                </mods:languageTerm>
            </mods:language>
        </xsl:if>
    </xsl:template>

    <xsl:template name="physicalDescription">
        <xsl:if
            test="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:biblScope[@type='pp']">
            <mods:physicalDescription>
                <mods:extent>
                    <xsl:value-of
                        select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:biblScope[@type='pp']"/>
                    <xsl:text> pages</xsl:text>
                </mods:extent>
            </mods:physicalDescription>
        </xsl:if>
    </xsl:template>

    <xsl:template name="subjects">
        <xsl:for-each
            select="document($MARCxml)//marc:record/marc:datafield[@tag='650']">
            <mods:subject authority="lcsh">
                <xsl:for-each
                    select="document($MARCxml)//marc:record/marc:datafield[@tag='650']/marc:subfield[@code='a']">
                    <mods:topic>
                        <xsl:value-of
                            select="."
                        />
                    </mods:topic>
                </xsl:for-each>
                <xsl:for-each
                    select="document($MARCxml)//marc:record/marc:datafield[@tag='650']/marc:subfield[@code='z']">
                    <mods:geographic>
                        <xsl:value-of
                            select="."
                        />
                    </mods:geographic>
                </xsl:for-each>
                <xsl:for-each
                    select="document($MARCxml)//marc:record/marc:datafield[@tag='650']/marc:subfield[@code='x']">
                    <mods:genre>
                        <xsl:value-of
                            select="."
                        />
                    </mods:genre>
                </xsl:for-each>
            </mods:subject>
        </xsl:for-each>
        <xsl:for-each
            select="document($MARCxml)//marc:record/marc:datafield[@tag='651']">
            <mods:subject authority="lcsh">
                <xsl:for-each
                    select="document($MARCxml)//marc:record/marc:datafield[@tag='651']/marc:subfield[@code='a']">
                    <mods:topic>
                        <xsl:value-of
                            select="."
                        />
                    </mods:topic>
                </xsl:for-each>
                <xsl:for-each
                    select="document($MARCxml)//marc:record/marc:datafield[@tag='651']/marc:subfield[@code='z']">
                    <mods:geographic>
                        <xsl:value-of
                            select="."
                        />
                    </mods:geographic>
                </xsl:for-each>
                <xsl:for-each
                    select="document($MARCxml)//marc:record/marc:datafield[@tag='651']/marc:subfield[@code='x']">
                    <mods:topic>
                        <xsl:value-of
                            select="."
                        />
                    </mods:topic>
                </xsl:for-each>
            </mods:subject>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="relatedItem">
        <mods:relatedItem type="host">
            <mods:titleInfo>
                <mods:title>
                    <xsl:value-of
                        select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:title"/>
                </mods:title>
            </mods:titleInfo>

            <xsl:for-each
                select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:respStmt">
                <xsl:if test="./TEI:name">
                    <mods:name>
                        <mods:namePart>
                            <xsl:value-of select="./TEI:name"/>
                        </mods:namePart>
                        <xsl:if test="./TEI:resp">

                            <xsl:if test="TEI:resp='Transcribed by'">
                                <mods:role>
                                    <mods:roleTerm type="text">transcriber</mods:roleTerm>
                                </mods:role>
                            </xsl:if>

                        </xsl:if>
                    </mods:name>
                </xsl:if>
            </xsl:for-each>

            <mods:location>
                <mods:url>
                    <!-- parameterize PURL prefix? maybe not necessary -->
                    <xsl:text>http://www.dlib.indiana.edu/collections/</xsl:text>
                    <xsl:value-of select="$repository"/>
                    <xsl:text>/</xsl:text>
                </mods:url>
            </mods:location>
        </mods:relatedItem>
    </xsl:template>

    <xsl:template name="identifier">
        <mods:identifier type="local">
            <xsl:value-of select="$collectionid"/>
        </mods:identifier>
    </xsl:template>

    <xsl:template name="location">
        <mods:location>
            <mods:url access="object in context" usage="primary display">
                <xsl:text>http://purl.dlib.indiana.edu/iudl/</xsl:text>
                <xsl:value-of select="$repository"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$collectionid"/>
            </mods:url>
            <mods:url access="raw object">
                <xsl:text>http://purl.dlib.indiana.edu/iudl/</xsl:text>
                <xsl:value-of select="$repository"/>
                <xsl:text>/printable/</xsl:text>
                <xsl:value-of select="$collectionid"/>
            </mods:url>
            <mods:url access="preview">
                <xsl:text>http://purl.dlib.indiana.edu/iudl/</xsl:text>
                <xsl:value-of select="$repository"/>
                <xsl:text>/thumbnail/</xsl:text>
                <xsl:value-of select="$collectionid"/>
            </mods:url>
        </mods:location>
    </xsl:template>

    <xsl:template name="accessCondition">
        <mods:accessCondition type="restriction on access">
            <xsl:value-of select="TEI:fileDesc/TEI:publicationStmt/TEI:availability/TEI:p[1]"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="TEI:fileDesc/TEI:publicationStmt/TEI:availability/TEI:p[2]"/>
        </mods:accessCondition>
    </xsl:template>

    <xsl:template name="recordInfo">
        <xsl:variable name="now" select="current-date()"/>
        <mods:recordInfo>
            <mods:recordContentSource>Indiana University Digital Library
                Program</mods:recordContentSource>
            <mods:recordCreationDate encoding="w3cdtf">
                <xsl:value-of select="format-date($now, '[Y0001]-[M01]-[D01]')"/>
            </mods:recordCreationDate>
            <xsl:call-template name="recordIdentifier"/>
            <mods:recordOrigin>MODS record generated from TEI record for the
                report.</mods:recordOrigin>
            <mods:languageOfCataloging>
                <mods:languageTerm type="text">English</mods:languageTerm>
                <mods:languageTerm type="code" authority="iso639-2b">eng</mods:languageTerm>
            </mods:languageOfCataloging>
        </mods:recordInfo>
    </xsl:template>

    <!--Templates called from originInfo-->
    <xsl:template name="publisher">
        <xsl:if
            test="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:publisher">
            <mods:publisher>
                <xsl:value-of
                    select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:publisher"
                />
            </mods:publisher>
        </xsl:if>
    </xsl:template>

    <xsl:template name="dateCreated">
        <xsl:if test="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:date">
            <mods:dateCreated keyDate="yes">
                <xsl:value-of
                    select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:date"
                />
            </mods:dateCreated>
        </xsl:if>
    </xsl:template>

    <xsl:template name="issuance">
        <xsl:if test="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:title[@level='s']">
            <mods:issuance>
                <xsl:text>continuing</xsl:text>
            </mods:issuance>
        </xsl:if>
    </xsl:template>

    <xsl:template name="placeTerm">
        <xsl:if
            test="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:pubPlace">
            <mods:place>
                <mods:placeTerm>
                    <xsl:value-of
                        select="TEI:fileDesc/TEI:sourceDesc/TEI:biblStruct/TEI:monogr/TEI:imprint/TEI:pubPlace"
                    />
                </mods:placeTerm>
            </mods:place>
        </xsl:if>
    </xsl:template>

    <!--Template called from recordInfo-->
    <xsl:template name="recordIdentifier">
        <mods:recordIdentifier>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$repository"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$collectionid"/>
        </mods:recordIdentifier>
    </xsl:template>

</xsl:stylesheet>
