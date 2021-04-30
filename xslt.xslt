<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- This is the xslt document where the xml gets converted to html -->
    <xsl:output method="html" />

    <xsl:template match="Businesses">
        <!-- This calls on the head of the document so the base page only gets printed once while the actual information is printed properly -->
        <html>
           <head>	

               <title>Businesses</title>		
               <meta charset="UTF-8" />
               <link rel="stylesheet" href="style.css" />

           </head>
           <body>
               <header>
                <h1>Service U</h1>
                <div class="topnav">
                    <a class="enlarge centremiddle" href="index.html">Home</a>
                    <a class="enlarge centremiddle" href="cleaning.xml">Cleaning Services</a>
                    <a class="enlarge centremiddle" href="construction.html">Remidal Massage</a>
                    <a class="enlarge centremiddle" href="landscaping.xml">Landscaping and Garden Services</a>
                    <a class="enlarge centremiddle" href="construction.html">Interior Decorating</a>
                    <a class="enlarge centremiddle" href="construction.html">Physical Training</a>
                    <a class="enlarge centremiddle" href="register.html">Register</a>
                </div>
            </header>
            <!-- From here the actual information is called from the 'Register' template -->
            <xsl:apply-templates select="Register">
            </xsl:apply-templates>		
            <hr/>

            <ul style="float:left; font-size: small;list-style-type: none;">
                <li>
                    <em><a href="privacy.html">Privacy Policy</a></em>
                </li>
                <li>
                    <em><a href="terms.html">Terms  Conditions</a></em>
                </li>
                <li>
                    <em><a href="about.html">About Us</a></em>
                </li>
                <li>
                    <em><a href="contact.html">Contact Us</a></em>
                </li>
            </ul>

            <address>
                <a href="https://www.w3schools.com/html/default.asp">Website built by:</a>
                <br/>
                Gary Beale
                <br/>
                c3328065
            </address>

        </body>

    </html>
</xsl:template>

<!-- This is the actual code that runs whenever there is a 'Register' tag, which is every time there is a new business -->
<xsl:template match="Register">
    <!-- This displays the name of the business -->
    <h1>
        <xsl:value-of select="Business_Details/Business_Name"/>
    </h1>

    <!-- This tells the reader what kind of business it is -->
    <p style="text-align: center;">

        <xsl:text>A </xsl:text>
        <xsl:value-of select="Business_Details/Service_Type"/>
        <xsl:text> Business</xsl:text>
        <br/>
        <br/>

        <!-- Here is where it is determained if there is a logo. If there is the count will equal 1 and the xslt will extract the image path and display it otherwise it will print that there is no logo -->
        <xsl:choose>
            <xsl:when test="count(Business_Details/Business_Logo) = 1">
                <xsl:for-each select="Business_Details/Business_Logo">
                    <img alt="Logo" height="200px" class="centre">
                        <xsl:attribute name="src">
                            <xsl:value-of select="."/>         
                        </xsl:attribute>            
                    </img>
                </xsl:for-each>

            </xsl:when>
            <xsl:otherwise>
                <xsl:text>(No given logo)</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <br/>
        <br/>


        <!-- This is a repeat of the previous code for the logo, but with images and will print all images listed as long as the number of images is more than 0 -->
        <xsl:choose>
            <xsl:when test="count(Business_Details/Pictures) > 0">
                <xsl:for-each select="Business_Details/Pictures">
                    <img alt="Business Image" height="200px" class="centre">
                        <xsl:attribute name="src">
                            <xsl:value-of select="."/>         
                        </xsl:attribute>            
                    </img>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>(No Images Provided)</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <br/>
        <br/>

        <!-- The website url provided is extracted from the xml document and displayed on the webpage as a link -->
        <a href="{Business_Details/URL}">Website</a>
        <br/>
        <br/>

        <!-- This is how the description of the business is pulled form the xml doc and displayed -->
        <xsl:value-of select="Business_Details/Business_Description"/>
        <br/>
        <br/>

        <!-- Here is how the document finds the names of all listed workers within the document, as if there is more than 0 workers listed it will print all names followed by a comma, otherwise it wil say there are no workers -->
        <xsl:choose>
            <xsl:when test="count(Business_Details/Workers) > 0">
                <xsl:text>Workers: </xsl:text>
                <xsl:for-each select="Business_Details/Workers">
                    <xsl:value-of select="."/>
                    <xsl:text>, </xsl:text>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>(No workers named)</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <br/>

        <!-- In similar fashion, the previous jobs and prerequisites of the business are displayed by determining if there is anything to display, if there is it will display, otherwise it will tell the reader there is nothing -->
        <xsl:text>Previous Jobs: </xsl:text>
        <xsl:choose>
            <xsl:when test="count(Business_Details/Previous_Jobs) = 0">
                <xsl:text>(None)</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="Business_Details/Previous_Jobs"/>
            </xsl:otherwise>
        </xsl:choose>
        <br/>

        <xsl:text>Prerequisites: </xsl:text>
        <xsl:choose>
            <xsl:when test="count(Business_Details/Prerequisites) = 0">
                <xsl:text>(None)</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="Business_Details/Prerequisites"/>
            </xsl:otherwise>
        </xsl:choose>
        <br/>

        <!-- These next 4 blocks of code all work in a similar fashion, by collecting the information in the xml document and printing it after a plain text title describing the nature of the data -->
        <xsl:text>Minimum Fee: $</xsl:text>
        <xsl:value-of select="In_Home_Services/Minimum_Fee"/>
        <br/>

        <xsl:text>Hourly Rate: $</xsl:text>
        <xsl:value-of select="In_Home_Services/Hourly_Rate"/>
        <br/>
        <br/>

        <!-- Within this block the xslt will extract an attribute from the xml document, in this case the state the business is located in and will display it inline with the rest of the information -->
        <xsl:text>Address: </xsl:text>
        <xsl:value-of select="Contact_Details/Address"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="Contact_Details/Address/@state"/>
        <br/>
        <br/>

        <xsl:value-of select="Contact_Details/Phone_Number"/>
        <br/>
        <br/>
        <br/>

    </p>

</xsl:template>

</xsl:stylesheet>