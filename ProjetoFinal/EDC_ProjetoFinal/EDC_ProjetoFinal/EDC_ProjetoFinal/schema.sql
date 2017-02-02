
CREATE XML SCHEMA COLLECTION [dbo].[AboutSCHEMA] AS
	'<?xml version="1.0" encoding="utf-8"?>
	<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	  <xs:element name="about">
		<xs:complexType>
		  <xs:all>
			<xs:element name="watchlist" minOccurs="0">
			  <xs:complexType>
				<xs:sequence>
				  <xs:element name="seen" maxOccurs="unbounded" minOccurs="0">
					<xs:complexType>
					  <xs:attribute name="user" type="xs:string" use="required" />
					</xs:complexType>
				  </xs:element>
				</xs:sequence>
			  </xs:complexType>
			</xs:element>
			<xs:element name="ratings" minOccurs="0">
			  <xs:complexType>
				<xs:sequence>
				  <xs:element name="rating" maxOccurs="unbounded" minOccurs="0">
					<xs:complexType>
					  <xs:attribute name="user" type="xs:string" use="required" />
					  <xs:attribute name="stars" type="xs:unsignedByte" use="required" />
					</xs:complexType>
				  </xs:element>
				</xs:sequence>
			  </xs:complexType>
			</xs:element>
			<xs:element name="reviews" minOccurs="0">
			  <xs:complexType>
				<xs:sequence>
				  <xs:element maxOccurs="unbounded" name="review" minOccurs="0">
					<xs:complexType>
					  <xs:attribute name="user" type="xs:string" use="required" />
					  <xs:attribute name="text" type="xs:string" use="required" />
					</xs:complexType>
				  </xs:element>
				</xs:sequence>
			  </xs:complexType>
			</xs:element>
			<xs:element name="wishlist" minOccurs="0">
			  <xs:complexType>
				<xs:sequence>
				  <xs:element name="favorite" maxOccurs="unbounded" minOccurs="0">
					<xs:complexType>
					  <xs:attribute name="user" type="xs:string" use="required" />
					</xs:complexType>
				  </xs:element>
				</xs:sequence>
			  </xs:complexType>
			</xs:element>
		  </xs:all>
		  <xs:attribute name="version" type="xs:decimal" use="required" />
		  <xs:attribute name="authors" type="xs:string" use="required" />
		</xs:complexType>
	  </xs:element>
	</xs:schema>';
GO