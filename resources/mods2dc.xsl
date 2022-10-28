<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="mods"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="mods:mods">
		<oai_dc:dc
			xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
			<xsl:apply-templates/>
		</oai_dc:dc>
	</xsl:template>

	<xsl:template match="mods:titleInfo">
		<xsl:choose>
			<xsl:when test="mods:subTitle">
				<dc:title>
					
					<xsl:value-of select="mods:title"/>
					<xsl:text> : </xsl:text>
					<xsl:value-of select="mods:subTitle"/>
				</dc:title>
			</xsl:when>

			<xsl:otherwise>
				<dc:title>
					<xsl:value-of select="mods:title"/>
				</dc:title>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="mods:name">
		<dc:creator>
			<xsl:call-template name="name"/>
		</dc:creator>
	</xsl:template>


	<xsl:template match="mods:subject">

		<!-- subjects that go in coverage -->
		<xsl:if
			test="mods:geographic | mods:hierarchicalGeographic | mods:cartographics | mods:geographicCode | mods:temporal">

			<xsl:for-each select="mods:geographic">
				<xsl:choose>
					<xsl:when test="preceding-sibling::*">
						
					</xsl:when>
					<xsl:otherwise>
								<dc:coverage>
									<xsl:value-of select="."/>
								</dc:coverage>
							
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

			<xsl:for-each select="mods:hierarchicalGeographic">
				<dc:coverage>
					<xsl:for-each
						select="mods:continent|mods:country|mods:provence|mods:region|mods:state|mods:territory|mods:county|mods:city|mods:island|mods:area">
						<xsl:value-of select="."/>
						<xsl:if test="position()!=last()">--</xsl:if>
					</xsl:for-each>
				</dc:coverage>
			</xsl:for-each>

			<xsl:for-each select="mods:cartographics/mods:coordinates">
				<dc:coverage>
					<xsl:value-of select="."/>
				</dc:coverage>
			</xsl:for-each>

			<xsl:for-each select="mods:geographicCode">
				<dc:coverage>
					<xsl:value-of select="."/>
				</dc:coverage>
			</xsl:for-each>

			<xsl:if test="mods:temporal">
				<dc:coverage>
					<xsl:for-each select="mods:temporal">
						<xsl:value-of select="."/>
						<xsl:if test="position()!=last()">-</xsl:if>
					</xsl:for-each>
				</dc:coverage>
			</xsl:if>
		</xsl:if>

		<!-- subjects that go in subject, including precoordinated headings -->
		<xsl:if
			test="mods:topic | mods:geographic | mods:temporal | mods:titleInfo | mods:name | mods:genre | mods:occupation">

			<dc:subject>
				<xsl:for-each select="*">
					<xsl:choose>
						<xsl:when test="local-name()='titleInfo'">
							<xsl:value-of select="mods:title"/>
						</xsl:when>
						<xsl:when test="local-name()='name'">
							<xsl:call-template name="name"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="position()!=last()">--</xsl:if>
				</xsl:for-each>
			</dc:subject>
		</xsl:if>
	</xsl:template>

	<xsl:template match="mods:abstract | mods:tableOfContents | mods:note">
		<dc:description>
			<xsl:value-of select="."/>
		</dc:description>
	</xsl:template>

	<xsl:template match="mods:originInfo">
		<dc:date>
			<xsl:value-of select="*[@keyDate='yes']"/>
		</dc:date>
	</xsl:template>

	<xsl:template match="mods:genre">
		<xsl:choose>
			<xsl:when test="@authority='dct'">
				<dc:type>
					<xsl:value-of select="."/>
				</dc:type>
				<xsl:for-each select="mods:typeOfResource">
					<dc:type>
						<xsl:value-of select="."/>
					</dc:type>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<dc:type>
					<xsl:value-of select="."/>
				</dc:type>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="mods:typeOfResource">
		<xsl:if test="@collection='yes'">
			<dc:type>Collection</dc:type>
		</xsl:if>
		<xsl:if test=". ='software' and ../mods:genre='database'">
			<dc:type>DataSet</dc:type>
		</xsl:if>
		<xsl:if test=".='software' and ../mods:genre='online system or service'">
			<dc:type>Service</dc:type>
		</xsl:if>
		<xsl:if test=".='software'">
			<dc:type>Software</dc:type>
		</xsl:if>
		<xsl:if test=".='cartographic material'">
			<dc:type>Image</dc:type>
		</xsl:if>
		<xsl:if test=".='multimedia'">
			<dc:type>InteractiveResource</dc:type>
		</xsl:if>
		<xsl:if test=".='moving image'">
			<dc:type>MovingImage</dc:type>
		</xsl:if>
		<xsl:if test=".='three dimensional object'">
			<dc:type>PhysicalObject</dc:type>
		</xsl:if>
		<xsl:if test="starts-with(.,'sound recording')">
			<dc:type>Sound</dc:type>
		</xsl:if>
		<xsl:if test=".='still image'">
			<dc:type>StillImage</dc:type>
		</xsl:if>
		<xsl:if test=". ='text'">
			<dc:type>Text</dc:type>
		</xsl:if>
		<xsl:if test=".='notated music'">
			<dc:type>Text</dc:type>
		</xsl:if>
	</xsl:template>

	<xsl:template match="mods:physicalDescription">
		<xsl:if test="mods:extent">
			<dc:format>
				<xsl:value-of select="mods:extent"/>
			</dc:format>
		</xsl:if>
		<xsl:if test="mods:form">
			<dc:format>
				<xsl:value-of select="mods:form"/>
			</dc:format>
		</xsl:if>
		<xsl:for-each select="mods:internetMediaType">
			<dc:format>
				<xsl:value-of select="."/>
			</dc:format>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="mods:identifier">
		<xsl:variable name="type"
			select="translate(@type,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:choose>
			<xsl:when test="contains ('isbn issn uri doi lccn uri', $type)">
				<dc:identifier>
					<xsl:value-of select="$type"/>: <xsl:value-of select="."/>
				</dc:identifier>
			</xsl:when>
			<xsl:otherwise>
				<dc:identifier>
					<xsl:value-of select="."/>
				</dc:identifier>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="mods:location">
		<xsl:for-each select="mods:url[@usage='primary display']">
			<dc:identifier>
				<xsl:value-of select="."/>
			</dc:identifier>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="mods:language">
		<xsl:choose>
			<xsl:when test="mods:languageTerm[@type='text']">
				<dc:language>
					<xsl:value-of select="normalize-space(mods:languageTerm[@type='text'])"/>
				</dc:language>
			</xsl:when>
			<xsl:otherwise>
				<dc:language>
					<xsl:value-of select="normalize-space(mods:languageTerm[@type='code'])"/>
				</dc:language>
			</xsl:otherwise>
		</xsl:choose>


	</xsl:template>

	<xsl:template
		match="mods:relatedItem[mods:titleInfo | mods:name | mods:identifier | mods:location]">
		<xsl:choose>
			<xsl:when test="@type='original'">
				<dc:source>
					<xsl:for-each
						select="mods:titleInfo/mods:title | mods:identifier | mods:location/mods:url">
						<xsl:if test="normalize-space(.)!= ''">
							<xsl:value-of select="."/>
							<xsl:if test="position()!=last()">--</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</dc:source>
			</xsl:when>
			<xsl:when test="@type='series'"/>
			<xsl:when test="@type='host'">
				<dc:source>
					<xsl:for-each
						select="mods:titleInfo/mods:title | mods:identifier | mods:location/mods:url | mods:abstract">
						<xsl:if test="normalize-space(.)!= ''">
							<xsl:value-of select="."/>
							<xsl:if test="position()!=last()">--</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</dc:source>
			</xsl:when>
			<xsl:otherwise>
				<dc:relation>
					<xsl:for-each
						select="//mods:location/mods:physicalLocation | mods:titleInfo/mods:title">
						<xsl:if test="normalize-space(.)!= ''">
							<xsl:value-of select="."/>
							<xsl:if test="position()!=last()">, </xsl:if>
						</xsl:if>
					</xsl:for-each>
				</dc:relation>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<xsl:template match="mods:accessCondition">
		<xsl:if test=".[.!='']">
			<dc:rights>
				<xsl:value-of select="."/>
			</dc:rights>
		</xsl:if>
		<xsl:if test=".[.='']">
			<dc:rights>
				<xsl:if test="./@displayLabel">
					<xsl:value-of select="@displayLabel"/>
					<xsl:text>: </xsl:text>
				</xsl:if>
				<xsl:if test="./@xlink:href">
					<xsl:value-of select="@xlink:href"/>
				</xsl:if>
			</dc:rights>
		</xsl:if>
	</xsl:template>

	<xsl:template name="name">
		<xsl:variable name="name">
			<xsl:for-each select="mods:namePart[not(@type)]">
				<xsl:value-of select="."/>
			</xsl:for-each>
			<xsl:value-of select="mods:namePart[@type='family']"/>
			<xsl:if test="mods:namePart[@type='given']">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="mods:namePart[@type='given']"/>
			</xsl:if>
			<xsl:if test="mods:namePart[@type='date']">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="mods:namePart[@type='date']"/>
				<xsl:text/>
			</xsl:if>
			<xsl:if test="mods:displayForm">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="mods:displayForm"/>
				<xsl:text>) </xsl:text>
			</xsl:if>
			<xsl:for-each select="mods:role[mods:roleTerm[@type='text']!='creator']">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text>) </xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:value-of select="normalize-space($name)"/>
	</xsl:template>

	<!-- suppress all else:-->
	<xsl:template match="*"/>

</xsl:stylesheet>
