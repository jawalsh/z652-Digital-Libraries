# Metadata Crosswalking XSLT Lab

_Oxygen help on creating XML transformations with XSLT is available at [https://www.oxygenxml.com/doc/versions/22.1/ug-editor/topics/xml-transformation-with-xslt.html](https://www.oxygenxml.com/doc/versions/22.1/ug-editor/topics/xml-transformation-with-xslt.html)_.

1.  Download some TEI/XML source files from Brevier Legistlative Reports ([http://dlib.indiana.edu/collections/law/brevier/](http://dlib.indiana.edu/collections/law/brevier/)). Bulk download of IU TEI files also available at [https://github.com/iulibdcs/tei\_text](https://github.com/iulibdcs/tei_text).
    
2.  Transform the TEI files to MODS in Oxygen using the [`tei2mods_Brevier.xsl`](https://raw.githubusercontent.com/jawalsh/z652-Digital-Libraries/main/resources/tei2mods_Brevier.xsl) XSLT file. 
    
3.  Transform your MODS files to Dublin Core in Oxygen using the [`mods2dc.xsl`](https://raw.githubusercontent.com/jawalsh/z652-Digital-Libraries/main/resources/mods2dc.xsl) XSLT file. 
    
4.  ADVANCED (optional): Figure out how to do bulk transformation of XML documents in Oxygen. Hint: You will want to create a “project,” and add your XML files to the project. Then review the “Batch Transformation” section in Oxygen help.