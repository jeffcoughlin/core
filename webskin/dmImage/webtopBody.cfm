<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Images Webtop Body --->

<cfimport taglib="/farcry/core/tags/formtools" prefix="ft">

<ft:objectadmin
	typename="dmImage"
    title="Image Library"
	lCustomColumns="Thumbnail:cellThumbnail,Title / Alt:cellDescription"
	columnList="catImage,datetimelastupdated"
	sortableColumns="title,datetimelastupdated"
	lFilterFields="title,alt,catImage"
	sqlorderby="datetimelastupdated DESC" />

<cfsetting enablecfoutputonly="false">