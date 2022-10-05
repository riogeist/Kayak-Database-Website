-- --------------------------------------------------------------------------
-- File: 	     PNWKayak_Queries.sql
-- Author:	   Jasper Riogeist
-- Date: 	     11/12/2021
-- Class:	     CS445
-- assignment: Assignment Two - Big Database
-- Purpose:	   Create queries for Big database.
-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- Query description: List all regions. This query will be used to populate a 
--                    a drop down box.
-- Output: Name, RegionID
-- Sorted: By Name
-- --------------------------------------------------------------------------
Select Name, RegionID
From Regions
Order By Name;

-- --------------------------------------------------------------------------
-- Query description: Returns ID of a named region. Testing query for use in 
--                    subquery below. 
-- Output: RegionID
-- Sorted: None
-- --------------------------------------------------------------------------
Select RegionID
From Regions
Where Name = 'Columbia Gorge';

-- --------------------------------------------------------------------------
-- Query description: List all rivers in a specific region. This query will
--                    populate a drop down box after the user selects
--                    a region.
-- Output: RiverName, RiverID
-- Sorted: By RiverName
-- --------------------------------------------------------------------------
Select Rivers.Name As RiverName, RiverID
From Rivers, Sections
Where Sections.RiverID = Rivers.RiverID 
	And Sections.RegionID = 1
Group By Rivers.Name
Order By Rivers.Name;

-- --------------------------------------------------------------------------
-- Query description: List all sections on a specific river. This query will
--                    output each sections data that is on the specific
--                    river.
-- Output: RiverName, SectionClass, SectionSeason, Length, Gradient, 
--         SectionRegion, SectionDescription
-- Sorted: By RiverName
-- --------------------------------------------------------------------------
Select Sections.Name, Classes.Rating As SectionClass, 
	Seasons.Name As SectionSeason, Length, Gradient,  
	Regions.Name As SectionRegion, Sections.Description As SectionDescription
From Sections, Classes, Seasons, Rivers, Regions
Where Sections.RiverID = 2 
	And Sections.ClassID = Classes.ClassID 
	And Sections.SeasonID = Seasons.SeasonID 
	And Sections.RegionID = Regions.RegionID
	And Sections.RiverID = Rivers.RiverID 
Order By Sections.Name;

-- --------------------------------------------------------------------------
-- Query description: Find which sections a user has done and output the 
--                   section data.
-- Output: Name, SectionClass, RiverName, Journal, Date
-- Sorted: By Date
-- --------------------------------------------------------------------------
Select Sections.Name As Name, Classes.Rating As SectionClass, 
	Rivers.Name As RiverName, UserDoneSections.Journal As Journal, 
	UserDoneSections.TimeCoordinates As 'Date'
From UserDoneSections, Sections, Classes, Rivers
Where UserDoneSections.SectionID = Sections.SectionID
	And UserDoneSections.UserID = 1
	And Sections.ClassID = Classes.ClassID
	And Sections.RiverID = Rivers.RiverID
Order By UserDoneSections.TimeCoordinates;

-- --------------------------------------------------------------------------
-- Query description: Find which waterfalls a user has done and output the 
--                    waterfall data.
-- Output: Name, Height, WaterfallClass, Jounral, Date
-- Sorted: By Date
-- --------------------------------------------------------------------------
Select Waterfalls.Name As Name, Waterfalls.Height As Height, 
	Classes.Rating As WaterfallClass, UserDoneWaterfalls.Journal As Journal, 
	UserDoneWaterfalls.TimeCoordinates As 'Date'
From UserDoneWaterfalls, Waterfalls, Classes
Where UserDoneWaterfalls.WaterfallID = Waterfalls.WaterfallID 
	And UserDoneWaterfalls.UserID = 1
	And Waterfalls.ClassID = Classes.ClassID
Order By UserDoneWaterfalls.TimeCoordinates;

-- --------------------------------------------------------------------------
-- Query description: Search for a section by name and output data.
-- Output: Name, SectionClass, SectionSeason, Length, Gradient, RiverName, 
--         SectionRegion, SectionDescription
-- Sorted: None
-- --------------------------------------------------------------------------
Select Sections.Name As Name, Classes.Rating As SectionClass, 
	Seasons.Name As SectionSeason, Length, Gradient, Rivers.Name As RiverName, 
	Regions.Name As SectionRegion, Sections.Description As SectionDescription
From Sections, Classes, Seasons, Rivers, Regions
Where Sections.Name Like "T%"
	And Sections.ClassID = Classes.ClassID 
	And Sections.SeasonID = Seasons.SeasonID 
	And Sections.RegionID = Regions.RegionID
	And Sections.RiverID = Rivers.RiverID;


-- --------------------------------------------------------------------------
-- Query description: list rivers in region given the region name.
-- Output: RiverName, RiverDescription
-- Sorted: By RiverName
-- --------------------------------------------------------------------------
-- list rivers in region given region name
Select Rivers.Name As RiverName, Rivers.Description As RiverDescription
From Rivers, Sections, Regions
Where Sections.RiverID = Rivers.RiverID 
	And Sections.RegionID = Regions.RegionID 
	And Regions.Name = 'Columbia Gorge'
Group By Rivers.Name
Order By Rivers.Name;

-- --------------------------------------------------------------------------
-- Query description: list waterfall data given waterfall name.
-- Output: WaterfallName, Height, WaterfallClass, WaterfallSection,
--         Waterfall Description
-- Sorted: None
-- --------------------------------------------------------------------------
Select Waterfalls.Name As WaterfallName, Height, 
	Classes.Rating As WaterfallClass, Sections.Name As WaterfallSection, 
	Waterfalls.Description As WaterfallDescription 
From Waterfalls, Classes, Sections
Where Waterfalls.SectionID = Sections.SectionID 
	And Waterfalls.ClassID = Classes.ClassID 
	And Waterfalls.SectionID = Sections.SectionID 
	And Waterfalls.Name = 'Husum';

-- --------------------------------------------------------------------------
-- Query description: list waterfall data given waterfall ID.
-- Output: WaterfallName, Height, WaterfallClass, WaterfallSection,
--         Waterfall Description
-- Sorted: None
-- --------------------------------------------------------------------------
Select Waterfalls.Name As WaterfallName, Height, 
		Classes.Rating As WaterfallClass, Sections.Name As WaterfallSection, 
		Waterfalls.Description As WaterfallDescription
From Waterfalls, Classes, Sections
Where Waterfalls.SectionID = Sections.SectionID 
	And Waterfalls.ClassID = Classes.ClassID 
	And Waterfalls.SectionID = Sections.SectionID 
	And Waterfalls.WaterfallID = 1;
		
-- --------------------------------------------------------------------------
-- Query description: Find sections where the section's name is like the
--                    input. 
-- Output: Name, SectionClass, SectionSeason, Length, Gradient, RiverName,
--         SectionRegion, SectionDescription
-- Sorted: None
-- --------------------------------------------------------------------------
Select Sections.Name, Classes.Rating as SectionClass, 
		Seasons.Name As SectionSeason, Length, Gradient, Rivers.Name As RiverName, 
		Regions.Name As SectionRegion, Sections.Description As SectionDescription
From Sections, Classes, Seasons, Rivers, Regions
Where Sections.Name Like 'T%'
	And Sections.ClassID = Classes.ClassID 
	And Sections.SeasonID = Seasons.SeasonID 
	And Sections.RegionID = Regions.RegionID
	And Sections.RiverID = Rivers.RiverID
		
-- --------------------------------------------------------------------------
-- Query description: from username, display the salt
-- Output: Salt
-- Sorted: none
-- --------------------------------------------------------------------------	
	Select Salt
	From Users
	Where Users.Username = 'BigEddy';
	
-- --------------------------------------------------------------------------
-- Query description: select all columns from a specific user whose username
--                    and password match those given.
-- Output: UserID, Username, Passwd, Salt, Email
-- Sorted: None
-- --------------------------------------------------------------------------
Select * 
From Users 
Where Username = 'BigEddy'
	And Passwd = '$2y$07$8d88bb4a9916b302c1c68OAbISwdMebAUg6kneNwBidaul3BymmYy';

-- --------------------------------------------------------------------------
-- Query description: display userID from username
-- Output: UserID
-- Sorted: None
-- --------------------------------------------------------------------------
Select UserID
From Users 
Where Username = 'BigEddy';

-- query format
-- --------------------------------------------------------------------------
-- Query description: 
-- Output:
-- Sorted: 
-- --------------------------------------------------------------------------













