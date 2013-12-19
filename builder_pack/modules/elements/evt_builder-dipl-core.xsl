<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:eg="http://www.tei-c.org/ns/Examples"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all">

	<xd:doc type="stylesheet">
		<xd:short>
			EN: Templates used to process the TEI elements of the CORE module.
			IT: I template per la trasformazione degli elementi TEI del modulo CORE.
		</xd:short>
	</xd:doc>


	<!--             -->
	<!-- Page layout -->
	<!--             -->

	<!-- P Paragraphs -->
	<xsl:template match="tei:p" mode="dipl">
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:value-of>dipl-<xsl:value-of select="name()"/></xsl:value-of></xsl:attribute>
			<xsl:apply-templates mode="#current"> </xsl:apply-templates>
		</xsl:element>
	</xsl:template>

	<!-- L Verse line-->
	<xsl:template match="tei:l" mode="dipl">
		<xsl:apply-templates mode="#current"/> 
		<xsl:text> </xsl:text><!--important-->
	</xsl:template>
	<!--<xsl:template match="tei:l" mode="dipl">
		<xsl:variable name="n"><xsl:value-of select="@n"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="following-sibling::tei:l[1]/@n=$n">
				<xsl:apply-templates mode="#current"> </xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="(@n mod 5 = 0)">
						<xsl:value-of select="."/>
						<span class="right">[<xsl:value-of select="@n"/>]</span>
						<xsl:value-of disable-output-escaping="yes">&lt;hr /&gt;</xsl:value-of>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates mode="#current"> </xsl:apply-templates>
						<xsl:value-of disable-output-escaping="yes">&lt;hr /&gt;</xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>-->

	<!-- Line break -->
	<!-- IT: Ignora i lb che hanno xml:id che termina con 'o' e riporta quelli che hanno xml:id che termina con 'r' eliminando quest'ultimo carattere -->
	<xsl:template match="tei:lb" mode="dipl">
		<xsl:choose>
			<xsl:when test="@xml:id">
				<xsl:choose>
					<xsl:when test="not(ends-with(@xml:id, 'orig'))">
						<xsl:element name="tei:lb">
							<xsl:copy-of select="@* except(@xml:id)"></xsl:copy-of>
							<xsl:attribute name="{@xml:id/name()}" select="if(ends-with(@xml:id, 'reg')) then(replace(@xml:id, 'reg', '')) else(@xml:id)"/>
						</xsl:element>
						<xsl:if test="@n">
							<xsl:element name="span">
								<xsl:attribute name="class" select="'dipl-lineN'"/>
								<xsl:value-of select="if(string-length(@n) &gt; 1) then(@n) else(concat('&#xA0;&#xA0;',@n))"/><xsl:text>&#xA0;&#xA0;</xsl:text>
							</xsl:element>
						</xsl:if>
					</xsl:when>
					<xsl:when test="ends-with(@xml:id, 'orig')"></xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:copy-of select="."/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

	<!-- Page break -->
	<xsl:template match="tei:pb" mode="dipl">
		<xsl:copy-of select="."/>
	</xsl:template>
	

	<!--               -->
	<!-- Transcription -->
	<!--               -->
	
	<!-- Choice -->
	<xsl:template match="tei:choice" mode="dipl" priority="3">
		<xsl:choose>
			<xsl:when test="@part=1 or @part=2 or @part=3">
				<xsl:apply-templates select="reg" mode="#current"/>
				<!--<xsl:variable name="reg2" select="following::tei:choice[@part=2][1]/tei:reg"/>
				<xsl:element name="span">
					<xsl:attribute name="class">
						<xsl:value-of>dipl-choice_popup</xsl:value-of>
					</xsl:attribute>
					<xsl:if test="tei:orig"><xsl:apply-templates select="tei:orig" mode="#current"/>
						<xsl:sequence select="' '"/></xsl:if>
					<xsl:apply-templates select="$reg2" mode="#current"> </xsl:apply-templates>
				</xsl:element>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="tei:sic">
						<xsl:element name="span">
							<xsl:attribute name="class">
								<xsl:value-of>dipl-choice_popup</xsl:value-of>
							</xsl:attribute>
							<xsl:if test="tei:corr">
								<xsl:element name="span">
									<xsl:attribute name="class" select="'dipl-corr'"/>
									<xsl:element name="span"><xsl:attribute name="class" select="'dipl-corr-resp'"/>
										<xsl:value-of select="tei:corr/@resp"/>
									</xsl:element><xsl:text>&#xA0;</xsl:text>
									<xsl:apply-templates select="tei:corr[not(child::node())]"/>
									<xsl:apply-templates select="tei:corr/node()" mode="#current"/>
								</xsl:element>
							</xsl:if>
							<xsl:element name="span">
								<xsl:attribute name="class" select="'dipl-sic'"></xsl:attribute>
								<xsl:apply-templates select="tei:sic[not(child::node())]"/>
								<xsl:apply-templates select="tei:sic/node()" mode="#current"/>
							</xsl:element>
						</xsl:element>
						
					</xsl:when>
					<xsl:when test="tei:expan">
						<xsl:apply-templates select="tei:expan" mode="#current"> </xsl:apply-templates>
					</xsl:when>
					<xsl:when test="tei:reg">
						<xsl:element name="span">
							<xsl:attribute name="class">
								<xsl:value-of>dipl-choice_popup</xsl:value-of>
							</xsl:attribute>
							<xsl:if test="tei:orig"><xsl:apply-templates select="tei:orig" mode="#current"/>
								<xsl:sequence select="' '"/><!--important--></xsl:if>
							
							<xsl:apply-templates select="tei:reg" mode="#current"> </xsl:apply-templates>
						</xsl:element>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="tei:abbr//tei:g | tei:sic//tei:g | tei:choice//tei:orig//tei:g" mode="dipl">
		<xsl:variable name="id" select="substring-after(@ref,'#')"/>
		<xsl:apply-templates select="if($root//tei:charDecl//tei:glyph[@xml:id=$id]/tei:mapping[@type='diplomatic']) then($root//tei:charDecl//tei:glyph[@xml:id=$id]/tei:mapping[@type='diplomatic']) else($root//tei:charDecl//tei:char[@xml:id=$id]/tei:mapping[@type='diplomatic'])" mode="#current"/>
	</xsl:template>
	
	<!-- SUBST substitution -->
	<xsl:template match="tei:subst" mode="dipl" priority="3">
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of>dipl-<xsl:value-of select="name()"/></xsl:value-of>
			</xsl:attribute>
			<xsl:apply-templates select="tei:del" mode="#current"></xsl:apply-templates>
			<xsl:apply-templates select="tei:add" mode="#current"></xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<!-- ADD Addition -->
	<xsl:template match="tei:add" mode="dipl" priority="2">
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of>dipl-<xsl:value-of select="name()"/></xsl:value-of>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="@place='sup'">
					\<xsl:element name="span">
						<xsl:attribute name="class">
							<xsl:value-of>dipl-<xsl:value-of select="@place"/></xsl:value-of>
						</xsl:attribute>
						<xsl:apply-templates mode="#current"> </xsl:apply-templates>
					</xsl:element>/
				</xsl:when>
				<xsl:when test="@place='sub'">
					/<xsl:element name="span">
						<xsl:attribute name="class">
							<xsl:value-of>dipl-<xsl:value-of select="@place"/></xsl:value-of>
						</xsl:attribute>
						<xsl:apply-templates mode="#current"> </xsl:apply-templates>
					</xsl:element>\
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="#current"> </xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	

	<!--EXPAN expansion
		DAMAGE Damage
		EX editorial expansion
		CORR Correction
		REG Regularization
		ORIG Original form
	-->
	<xsl:template match="tei:expan|tei:damage|tei:ex|tei:corr|tei:reg|tei:orig|tei:abbr" mode="dipl">
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of>dipl-<xsl:value-of select="name()"/></xsl:value-of>
			</xsl:attribute>
			<xsl:apply-templates mode="#current"/> 
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="tei:sic" mode="dipl">
		<!-- do nothing -->
	</xsl:template>
	
	<!-- DEL Deletions -->
	<xsl:template match="tei:del" mode="dipl">
		<xsl:element name="span">
			<xsl:attribute name="class">
				<xsl:value-of>dipl-<xsl:value-of select="name()"/></xsl:value-of>
			</xsl:attribute>[[<xsl:apply-templates mode="#current"/>]]</xsl:element>
	</xsl:template>

	<!-- HI Highlighted text -->
	<xsl:template match="tei:hi" mode="dipl">
		<xsl:choose>
			<xsl:when test="@rend='red'">
				<xsl:element name="span">
					<xsl:attribute name="class"><xsl:value-of>dipl-<xsl:value-of select="@rend"/></xsl:value-of></xsl:attribute>
					<xsl:apply-templates mode="#current"> </xsl:apply-templates>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="span">
					<xsl:attribute name="class">dipl-hi-<xsl:value-of select="translate(@rend, '.', '_')"/></xsl:attribute>
					<xsl:apply-templates mode="#current"> </xsl:apply-templates>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
