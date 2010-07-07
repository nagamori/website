<?xml version="1.0" encoding="utf8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	>
	
<xsl:output
	method="xml"
	indent="yes"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
	doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	/> <!-- CHECKME: are the doctypes still required, or even correct for XHTML+RDFa? -->

<xsl:include href="../../2008-01-14/headers/intro.history.xsl"/> <!-- FIXME: instead import this as XML using document() relative to $sect.dir -->

<xsl:param name="todaysDate" select="substring-before(document('http://xobjex.com/service/date.xsl')/date/utc/@stamp,'T')"/>

<xsl:param name="sect.dir"></xsl:param>
<xsl:param name="section1"	select="concat($sect.dir,'/dcterms-properties.xml')" />
<xsl:param name="section2"	select="concat($sect.dir,'/dcelements.xml')" />
<xsl:param name="section3"	select="concat($sect.dir,'/dcterms-ves.xml')" />
<xsl:param name="section4"	select="concat($sect.dir,'/dcterms-ses.xml')" />
<xsl:param name="section5"	select="concat($sect.dir,'/dcterms-classes.xml')" />
<xsl:param name="section6"	select="concat($sect.dir,'/dctype.xml')" />
<xsl:param name="section7"	select="concat($sect.dir,'/dcam.xml')" />

<xsl:variable name="sec1-doc" select="document($section1)"/>
<xsl:variable name="sec2-doc" select="document($section2)"/>
<xsl:variable name="sec3-doc" select="document($section3)"/>
<xsl:variable name="sec4-doc" select="document($section4)"/>
<xsl:variable name="sec5-doc" select="document($section5)"/>
<xsl:variable name="sec6-doc" select="document($section6)"/>
<xsl:variable name="sec7-doc" select="document($section7)"/>

<xsl:template match="/">
	<html>
		<head>
			<title>
				<xsl:value-of select="H1/Title"/>
			</title>
			<xsl:comment>#exec cgi="/cgi-bin/metawriter.cgi" </xsl:comment>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
			<link rel="meta" href="index.shtml.rdf" />
			<link rel="stylesheet" href="/css/default.css" type="text/css" />
		</head>	
		<body>
			<xsl:comment>#include virtual="/ssi/header.shtml" </xsl:comment>
			<xsl:call-template name="print-body"/>
			<xsl:comment>#include virtual="/ssi/footer.shtml" </xsl:comment>
		</body>
	</html>
</xsl:template>

<xsl:template name="print-body">
	<table cellspacing="0" class="docinfo">	 
		<xsl:for-each select="H1/*">
			<xsl:call-template name="print_heading">
				<xsl:with-param name="elem" select="local-name()"/>
				<xsl:with-param name="label" select="@label"/>
				<xsl:with-param name="value" select="."/>
			</xsl:call-template>
		</xsl:for-each>
<!--
<tr>
  <th>Date Valid:</th>
  <td><xsl:value-of select="$todaysDate"/></td>
</tr>
-->
	</table>

	<xsl:call-template name="history_intro"/>

	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec1-doc/dc/term">
			<xsl:sort select="./Name"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec2-doc/dc/term">
			<xsl:sort select="./Name"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec3-doc/dc/term">
			<xsl:sort select="./Name"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec4-doc/dc/term">
			<xsl:sort select="./Name"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec5-doc/dc/term">
			<xsl:sort select="./Name"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec6-doc/dc/term">
			<xsl:sort select="./Name"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec7-doc/dc/term">
			<xsl:sort select="./Name"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template name="print_heading">
	<xsl:param name="elem"/>
	<xsl:param name="label"/>
	<xsl:param name="value"/>
	<tr>
		<th><xsl:value-of select="translate($elem, '-', ' ')"/>:</th>
		<td>
			<xsl:choose>
				<xsl:when test="(starts-with($value, 'http://')) or (starts-with($value, 'mailto:'))">
					<xsl:choose>
						<xsl:when test="$label">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="$value"/>
								</xsl:attribute>
								<xsl:value-of select="$label"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="$value"/>
								</xsl:attribute>
								<xsl:value-of select="$value"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$elem='Title'">
							<xsl:value-of select="$value"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$value"/>
						</xsl:otherwise>
					</xsl:choose>	
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
</xsl:template>

<xsl:template match="term">
	<tr>
		<th colspan="2">
			<a>
				<xsl:attribute name="name">
					<xsl:value-of select="Anchor"/>
				</xsl:attribute>
			</a>
			<xsl:text disable-output-escaping='yes'> </xsl:text>
			<xsl:value-of select="'Term Name: '"/>
			<xsl:text disable-output-escaping='yes'> </xsl:text>
			<xsl:value-of select="Name"/>
		</th>
	</tr>
	<xsl:for-each select="descendant::node()">
		<xsl:choose>
			<xsl:when test="local-name() = ''"/>
			<xsl:when test="local-name() = 'Anchor'"/>
			<xsl:when test="local-name() = 'Name'"/>
			<xsl:when test="(local-name() = 'Version') or
				(local-name() = 'Type-of-Term') or
				(local-name() = 'Status') or
				(local-name() = 'Decision') or
				(local-name() = 'Replaces') or
				(local-name() = 'Is-Replaced-By')"
				>
				<tr>
					<td>
						<xsl:value-of select="translate(local-name(), '-', ' ')"/>:
					</td>
					<td>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="."/>
							</xsl:attribute>
							<xsl:choose>
								<xsl:when test="contains(., '#')">
									<xsl:value-of select="substring-after(., '#')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<xsl:value-of select="translate(local-name(), '-', ' ')"/>:
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="(starts-with(., 'http://')) or (starts-with(., 'mailto:'))">
								<xsl:choose>
									<xsl:when test="@label">
										<a>
											<xsl:attribute name="href">
												<xsl:value-of select="."/>
											</xsl:attribute>
											<xsl:value-of select="@label"/>
										</a>
									</xsl:when>
									<xsl:otherwise>
										<a>
											<xsl:attribute name="href">
												<xsl:value-of select="."/>
											</xsl:attribute>
											<xsl:value-of select="."/>
										</a>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
</xsl:template>

</xsl:transform>
