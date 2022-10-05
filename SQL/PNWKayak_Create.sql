-- --------------------------------------------------------------------------
-- File: 	     PNWKayak_Create.sql
-- Author:	   Jasper Riogeist
-- Date: 	     11/12/2021
-- Class:	     CS445
-- Assignment: Assignment Two - Big Database
-- Purpose:	   Build a database for Big Database
-- --------------------------------------------------------------------------
Drop Table If Exists SectionsCategories;
Drop Table If Exists UserDoneWaterfalls;
Drop Table If Exists UserDoneSections;
Drop Table If Exists Waterfalls;
Drop Table If Exists PutIns;
Drop Table If Exists TakeOuts;
Drop Table If Exists Sections;
Drop Table If Exists Rivers;
Drop Table If Exists Classes;
Drop Table If Exists Regions;
Drop Table If Exists SectionTypes;
Drop Table If Exists Seasons;
Drop Table If Exists Users;

Create Table Users
(
	UserID Int Not Null Auto_Increment,
	Username Varchar(25) Not Null,
	Passwd Varbinary(512) Null,
	Salt Varbinary(512) Null,
	Email Varchar(50) Default Null,
	Constraint Users_PK Primary Key (UserID)
) Engine=InnoDB Character Set = utf8 Collate = utf8_bin;

Create Table Seasons
(
	SeasonID Int Not Null Auto_Increment,
	Name Varchar(50),
	Constraint Seasons_PK Primary Key (SeasonID)
) Engine=InnoDB;

Create Table SectionTypes
(
	SectionTypeID Int Not Null Auto_Increment,
	Name Varchar(50),
	Description Text,
	Constraint SectionTypes_PK Primary Key (SectionTypeID)
) Engine=InnoDB;

Create Table Regions
(
	RegionID Int Not Null Auto_Increment,
	Name Varchar(50),
	Description Text,
	Constraint RegionID_PK Primary Key (RegionID)
) Engine=InnoDB;

Create Table Classes
(
	ClassID Int Not Null Auto_Increment,
	Rating Varchar(4) Not Null,
	Description Text,
	Constraint Classes_PK Primary Key (ClassID)
) Engine=InnoDB;

Create Table Rivers
(
	RiverID Int Not Null Auto_Increment,
	Name Varchar(50),
	Description Text,
	Constraint Rivers_PK Primary Key (RiverID)
) Engine=InnoDB;

Create Table Sections
(
	SectionID Int Not Null Auto_Increment,
	RiverID Int Not Null,
	ClassID Int Not Null,
	SeasonID Int Not Null,
	RegionID Int Not Null,
	Name Varchar(50),
	Gradient Int,
	Length Int,
	Description Text,
	Constraint Sections_PK Primary Key (SectionID),
	
	Constraint Sections_RiverID_FK Foreign Key (RiverID)
		References Rivers(RiverID) On Delete Cascade,
		
	Constraint Sections_ClassID_FK Foreign Key (ClassID)
		References Classes(ClassID) On Delete Cascade,
		
	Constraint Sections_SeasonID_FK Foreign Key (SeasonID)
		References Seasons(SeasonID) On Delete Cascade,
		
	Constraint Sections_RegionID_FK Foreign Key (RegionID)
		References Regions(RegionID) On Delete Cascade
) Engine=InnoDB;

Create Table TakeOuts
(
	TakeOutID Int Not Null Auto_Increment,
	SectionID Int Not Null,
	TakeOutDescription Text,
	Constraint PutInsTakeOuts_PK Primary Key (TakeOutID),
	
	Constraint TakeOuts_SectionID_FK Foreign Key (SectionID)
		References Sections(SectionID) On Delete Cascade
) Engine=InnoDB;

Create Table PutIns
(
	PutInID Int Not Null Auto_Increment,
	SectionID Int Not Null,
	PutInDescription Text,
	Constraint PutInsTakeOuts_PK Primary Key (PutInID),
	
	Constraint PutIns_SectionID_FK Foreign Key (SectionID)
		References Sections(SectionID) On Delete Cascade
) Engine=InnoDB;

Create Table Waterfalls
(
	WaterfallID Int Not Null Auto_Increment,
	ClassID Int Not Null,
	SectionID Int Not Null,
	Name Varchar(50),
	Height Int,
	Description Text,
	Constraint Waterfalls_PK Primary Key (WaterfallID),
	
	Constraint Waterfalls_ClassID_FK Foreign Key (ClassID)
		References Classes(ClassID) On Delete Cascade,
		
	Constraint Waterfalls_SectionID_FK Foreign Key (SectionID)
		References Sections(SectionID) On Delete Cascade
) Engine=InnoDB;

Create Table UserDoneWaterfalls
(
	UserID Int Not Null,
	WaterfallID Int Not Null,
	Journal Text Default Null,
	TimeCoordinates Date Default Null,
	
	Constraint UserDoneWaterfalls_PK 
	Primary Key (UserID, WaterfallID, TimeCoordinates),
	
	Constraint UserDoneWaterfalls_UserID_FK Foreign Key (UserID)
		References Users(UserID) On Delete Cascade,
		
	Constraint UserDoneWaterfalls_WaterfallID_FK Foreign Key (WaterfallID)
		References Waterfalls(WaterfallID) On Delete Cascade	
) Engine=InnoDB;


Create Table UserDoneSections
(
	UserID Int Not Null,
	SectionID Int Not Null,
	Journal Text Default Null,
	TimeCoordinates Date Default Null,	
	
	Constraint UserDoneSections_PK 
	Primary Key (UserID, SectionID, TimeCoordinates),
	
	Constraint UserDoneSections_UserID_FK Foreign Key (UserID)
		References Users(UserID) On Delete Cascade,
		
	Constraint UserDoneSections_SectionID_FK Foreign Key (SectionID)
		References Sections(SectionID) On Delete Cascade
) Engine=InnoDB;

Create Table SectionsCategories
(
	SectionID Int Not Null,
	SectionTypeID Int Not Null,
	
	Constraint SectionsCategories_PK Primary Key (SectionID, SectionTypeID),
	
	Constraint SectionsCategories_SectionID_FK Foreign Key (SectionID)
		References Sections(SectionID) On Delete Cascade,
	
	Constraint SectionsCategories_SectionTypeID_FK Foreign Key (SectionTypeID)
		References SectionTypes(SectionTypeID) On Delete Cascade
	
) Engine=InnoDB;

-- Data Insertion --

-- Users
Insert Into Users (Username, Passwd, Salt, Email) Values
('BigEddy', '$2y$07$8d88bb4a9916b302c1c68OAbISwdMebAUg6kneNwBidaul3BymmYy', 'NaCl', 'bigeddy@gmail.com'),            -- password is Unhashedpswd
('TheMountainGoat', '$2y$07$8d88bb4a9916b302c1c68OOPcdvlrYAKK6ot053/d.TMdS01JmFMy', 'Na2CO3', 'thegoat@gmail.com');  -- password is AnotherUnhashedpswd

-- Seasons
Insert Into Seasons (Name) Values
('dam-controlled'), 
('year-round'), 
('rainy'), 
('snowmelt'), 
('rainy/snowmelt');

-- SectionTypes
Insert Into SectionTypes (Name) Values
('Forested Canyon'),
('Forested'),
('Popular Area'),
('Gorge'),
('Residential'),
('Roadless Canyon');

-- Regions
Insert Into Regions (Name, Description) Values
('Columbia Gorge', 'Whitewater kayaking in the Columbia River Gorge is very 
popular on the White Salmon, Klickitat, Deschutes and Clackamas Rivers. 
Professional kayakers travel from all over the world to challenge themselves 
on the renown class V whitewater waves and waterfalls. There are options for 
all levels of kayaking, from beginner kayaking on the Klickitat, to advanced 
on the White Salmon and Wind River, and expert kayaking on the White Salmon 
and Little White Salmon.'),
('Willamette Valley', 'The Willamette Valley is a 150-mile long valley in 
Oregon, in the Pacific Northwest region of the United States. The Willamette 
River flows the entire length of the valley, and it is surrounded by 
mountains on three sides – the Cascade Range to the east, the Oregon Coast 
Range to the west, and the Calapooya Mountains to the south.');

-- Classes
Insert Into Classes (Rating, Description) Values
('1', 'Fast moving water with riffles and small waves. Few obstructions, all 
obvious and easily missed with little training. Risk to swimmers is slight; 
self-rescue is easy.'),
('2-', 'Straightforward rapids with wide, clear channels which are evident 
without scouting. Occasional maneuvering may be required, but rocks and 
medium-sized waves are easily avoided by trained paddlers. Swimmers are 
seldom injured and group assistance, while helpful, is seldom needed. 
Rapids that are at the lower end of this difficulty range are designated 
Class 2-.'),
('2', 'Straightforward rapids with wide, clear channels which are evident 
without scouting. Occasional maneuvering may be required, but rocks and 
medium-sized waves are easily avoided by trained paddlers. Swimmers are 
seldom injured and group assistance, while helpful, is seldom needed.'),
('2+', 'Straightforward rapids with wide, clear channels which are evident 
without scouting. Occasional maneuvering may be required, but rocks and 
medium-sized waves are easily avoided by trained paddlers. Swimmers are 
seldom injured and group assistance, while helpful, is seldom needed. 
Rapids that are at the upper end of this difficulty range are designated 
Class 2+.'),
('3-', 'Rapids with moderate, irregular waves which may be difficult to avoid 
and which can swamp an open canoe. Complex maneuvers in fast current and good 
boat control in tight passages or around ledges are often required; large 
waves or strainers may be present but are easily avoided. Strong eddies and 
powerful current effects can be found, particularly on large-volume rivers. 
Scouting is advisable for inexperienced parties. Injuries while swimming are 
rare; self-rescue is usually easy but group assistance may be required to 
avoid long swims. Rapids that are at the lower end of this difficulty range 
are designated 3-.'),
('3', 'Rapids with moderate, irregular waves which may be difficult to avoid 
and which can swamp an open canoe. Complex maneuvers in fast current and good 
boat control in tight passages or around ledges are often required; large 
waves or strainers may be present but are easily avoided. Strong eddies and 
powerful current effects can be found, particularly on large-volume rivers. 
Scouting is advisable for inexperienced parties. Injuries while swimming are 
rare; self-rescue is usually easy but group assistance may be required to 
avoid long swims.'),
('3+', 'Rapids with moderate, irregular waves which may be difficult to avoid 
and which can swamp an open canoe. Complex maneuvers in fast current and good 
boat control in tight passages or around ledges are often required; large 
waves or strainers may be present but are easily avoided. Strong eddies and 
powerful current effects can be found, particularly on large-volume rivers. 
Scouting is advisable for inexperienced parties. Injuries while swimming are 
rare; self-rescue is usually easy but group assistance may be required to 
avoid long swims. Rapids that are at the upper end of this difficulty range 
are designated 3+.'),
('4-', 'Intense, powerful but predictable rapids requiring precise boat 
handling in turbulent water. Depending on the character of the river, it 
may feature large, unavoidable waves and holes or constricted passages 
demanding fast maneuvers under pressure. A fast, reliable eddy turn may 
be needed to initiate maneuvers, scout rapids, or rest. Rapids may require 
"must make" moves above dangerous hazards. Scouting may be necessary the 
irst time down. Risk of injury to swimmers is moderate to high, and water 
conditions may make self-rescue difficult. Group assistance for rescue is 
often essential but requires practiced skills. For kayakers, a strong roll 
is highly recommended. Rapids that are at the lower end of this difficulty 
range are designated 4-'),
('4', 'Intense, powerful but predictable rapids requiring precise boat 
handling in turbulent water. Depending on the character of the river, it 
may feature large, unavoidable waves and holes or constricted passages 
demanding fast maneuvers under pressure. A fast, reliable eddy turn may 
be needed to initiate maneuvers, scout rapids, or rest. Rapids may require 
"must make" moves above dangerous hazards. Scouting may be necessary the 
irst time down. Risk of injury to swimmers is moderate to high, and water 
conditions may make self-rescue difficult. Group assistance for rescue is 
often essential but requires practiced skills. For kayakers, a strong roll 
is highly recommended.'),
('4+', 'Intense, powerful but predictable rapids requiring precise boat 
handling in turbulent water. Depending on the character of the river, it 
may feature large, unavoidable waves and holes or constricted passages 
demanding fast maneuvers under pressure. A fast, reliable eddy turn may 
be needed to initiate maneuvers, scout rapids, or rest. Rapids may require 
"must make" moves above dangerous hazards. Scouting may be necessary the 
irst time down. Risk of injury to swimmers is moderate to high, and water 
conditions may make self-rescue difficult. Group assistance for rescue is 
often essential but requires practiced skills. For kayakers, a strong roll 
is highly recommended. Rapids that are at the upper end of this difficulty 
range are designated 4+.'),
('5', 'Extremely long, obstructed, or very violent rapids which expose a 
paddler to added risk. Drops may contain large, unavoidable waves and holes 
or steep, congested chutes with complex, demanding routes. Rapids may 
continue for long distances between pools, demanding a high level of fitness. 
What eddies exist may be small, turbulent, or difficult to reach. At the high 
end of the scale, several of these factors may be combined. Scouting is 
recommended but may be difficult. Swims are dangerous, and rescue is often 
difficult even for experts. Proper equipment, extensive experience, and 
practiced rescue skills are essential. Because of the large range of difficulty 
that exists beyond Class IV, Class V is an open-ended, multiple-level scale 
designated by class 5.0, 5.1, 5.2, etc. Each of these levels is an order of 
magnitude more difficult than the last. That is, going from Class 5.0 to 
Class 5.1 is a similar order of magnitude as increasing from Class IV to 
Class 5.0.'),
('6', 'Runs of this classification are rarely attempted and often exemplify 
the extremes of difficulty, unpredictability and danger. The consequences of 
errors are severe and rescue may be impossible. For teams of experts only, at 
favorable water levels, after close personal inspection and taking all 
precautions. After a Class VI rapid has been run many times, its rating 
may be changed to an appropriate Class 5.x rating.');

-- Rivers
Insert Into Rivers (Name, Description) Values
('Canyon Creek of the Lewis', 'Just a short distance north of Portland, 
Canyon Creek is a popular run for the after work crowd once daylight savings 
time hits. Dedicated paddlers also paddle this run before work in the winter 
for their morning adrenaline fix, or do multiple laps if they have more time. 
While it takes a little longer your first time down, you can bomb down the 
run in an hour once you know the lines.  This river is a unique and valued 
whitewater resource for local paddlers and a destination for paddlers from 
around the world who make Portland a stop on their whitewater road trips. 
Consistent flows throughout all but the dry summer months, accessibility to 
the Portland paddling community, and great rapids make this a unique 
whitewater resource with significantly more available user days than many 
comparable runs in the region. The race course from Thrasher down to the 
Hammering Spot is widely regarded as one of the best sections in the country 
for a creeking race.'),
('White Salmon', 'The White Salmon River is a 44-mile tributary of the 
Columbia River in the U.S. state of Washington. Originating on the slopes of 
Mount Adams, it flows into the Columbia Gorge near the community of 
Underwood. Parts of the river have been designated Wild and Scenic. The 
principal tributaries of the White Salmon River include Trout Lake and Buck, 
Mill, Dry, Gilmer, and Rattlesnake Creeks.'),
('Clackamas', 'The Clackamas River is located to the west of the Cascade 
Range and to the south of the Columbia River Gorge in northern Oregon. 
Flowing northwest from its sources high in the Cascade Mountains, the 
designated portion of the river, which is 47 miles in length, runs from Big 
Spring (headwaters area) to Big Cliff, just south of the town of Estacada. 
This most picturesque region is entirely within the Mt. Hood National Forest 
and encompasses forested lands, wetlands, riparian areas and rock cliffs.'),
('Sandy', 'The Sandy River originates in the high glaciers of Mt. Hood, the 
most prominent peak in Oregons Cascade Mountains. Riverside trails offer 
spectacular scenery, easily observed geologic features, unique plant 
communities and a variety of recreational opportunities. Just outside 
Portland, the lower reaches of the Sandy River flows through a deep, winding, 
forested gorge known for its anadromous fish runs, botanical diversity, 
recreational boating and beautiful parks.'),
('Hood', 'The Hood River, formerly known as Dog River, is a tributary of the 
Columbia River in northwestern Oregon, United States. Approximately 25 miles 
long from its mouth to its farthest headwaters on the East Fork, the river 
descends from wilderness areas in the Cascade Range on Mount Hood and flows 
through the agricultural Hood River Valley to join the Columbia River in the 
Columbia River Gorge.');

-- Sections  - note that gradient is in fpm and length is in mi.
Insert Into Sections 
(Name, RiverID, ClassID, RegionID, SeasonID, Gradient, Length, Description) 
Values
('Fly Creek to Merwin Reservoir', 1, 10, 1, 3, '100', '4.3', 'Canyon Creek 
is a rainy season classic for Portland area boaters. This photogenic run 
offers lots of clean, high quality ledges ranging in height from 5-20 feet. 
While this run provides plenty of entertainment for experts, at low flows the 
pool drop nature serves as a great training ground for aspiring creek 
boaters.'),
('The Farmlands', 2, 10, 1, 5, '60', '5.1', 'This section of the White 
Salmon is named "The Farmlands" after the nearby farms that the river 
flows through. It is intimidating Class IV and IV+ with a 15-ish foot 
waterfall. Lava Falls and some of the harder rapids can be portaged 
making this a good run for confident Class IV+ paddlers.'),
('The Green Truss', 2, 10, 1, 5, '119', '5', 'The Green Truss section of 
the White Salmon is a classic Class 5 run in the Columbia Gorge. It has some 
big rapids and a handful of waterfalls. Every rapid is runnable but most people 
do a few portages.'),
('BZ Corner to Husum', 2, 7, 1, 2, '76', '5', 'Known as the Middle White 
Salmon, this is a run on which a great many kayakers have cut their class 3 
teeth. On a hot afternoon, the cold, clear water, nice lunch spots, and good 
play spots draw rafters and kaykers to thei scenic canyon. The rapids are 
fairly continuous, especially during the first few miles. Be aware of Husum 
Falls at the end of the run.'),
('Upper Clackamas', 3, 7, 2, 2, '37', '13.1', 'The Upper Clackamas River 
from Three Lynx to North Fork is a great 13 mile winter/spring run close to 
Portland, OR. Youll experience continuous class II/III whitewater with some 
class 4 excitement thrown in. This is among the most popular rafting trips 
in northern Oregon due to its proximity to Portland, great whitewater, 
camping opportunities, and classic Pacific Northwest scenery. Oregon 224 
follows the river which makes it easy to scout rapids and to do a shorter 
run.'),
('Sandy Gorge', 4, 9, 1, 5, '42', '12.8', 'The Sandy Gorge is a great, 
pool drop, class 3-4 run just a little over an hour away from Portland. 
This is a great run, with a handful of fun pool drop rapids and boulder 
gardens. However, it often collects wood, so paddle with caution, keep 
your eyes open, and do your best to get the most recent beta on any new 
wood.'),
('Revenue Bridge to Dodge Park', 4, 3, 1, 5, '40', '5', 'This is a 
delightful stretch that feels remote and has mostly class 2 feel except 
for a couple of class 3 rapids near the end of the run.  Keep your 
eyes peeled for the great surfing waves especially in some of the 
shelfier sections.  '),
('Tucker Bridge to Hood River Marina', 5, 7, 1, 5, '66', '7.5', 'The Dee 
to Tucker stretch of the Hood River is a classic Class 4 run in the Columbia 
Gorge. Most people start in the hamlet of Dee and paddle the short, 
continuous section of Class 3 and 4 rapids to Tucker Bridge. Many also choose 
to continue along down the Lower Hood all the way to the Columbia River for a 
full day trip.'),
('Dee to Tucker', 5, 9, 1, 5, '60', '5', 'The Hood River starts on the 
northern side of Mt. Hood in Oregon and is a tributary to the Columbia River. 
A popular day-trip for Columbia River Gorge natives since the removal of the 
Powerdale Dam in 2010, the Lower Hood run from Tucker Bridge to the Columbia 
River is beautiful and tons of fun. Perfect for kayakers and rafters alike, 
the river generally runs half the year from November to June depending on 
rain and snowmelt. The water is typically continuous Class 3 water with 
potential Class 4 consequences. At high water (above 6 ft.) the river 
becomes a definite Class 4 run. Youll boat through a small forested canyon 
with awesome views of Mt. Hood when clouds are minimal. In Spring it is 
typical to see Great Blue Heron, Merganser and Harlequin ducks, and hundreds 
of swallows swooping to and fro across the river.');

-- TakeOuts
Insert Into TakeOuts (SectionID, TakeOutDescription) Values
(1, 'Stairs under the bridge at Merwin Reservoir.'),
(2, 'The take-out is at the Green Truss Bridge. Manageable for kayaks but 
tough for rafts. Most rafters set up a pulley system on the bridge and use 
their truck to pull the rafts.'),
(3, 'BZ Corner.'),
(4, 'Husum Falls.'),
(5, 'Memaloose.'),
(6, 'Revenue Bridge, Sandy, Oregon.'),
(7, 'Dodge Park, Sandy, Oregon.'),
(8, 'Columbia River.'),
(9, 'Tucker Bridge');

-- PutIns
Insert Into PutIns (SectionID, PutInDescription) Values
(1, 'Upstream of the NE Healy Road bridge where it crosses the river at it’s confluence with Fly Creek.'),
(2, 'Go past BZ Corner, take a right onto Warner Road. Follow Warner Road for approximately 1 mile to 
the first bridge. Put-in is on the northeast side of the bridge.'),
(3, 'Green Truss Bridge.'),
(4, 'BZ Corner.'),
(5, 'Sandstone Bridge.'),
(6, 'Marmot Bridge, Sandy, Oregon.'),
(7, 'Revenue Bridge, Sandy, Oregon.'),
(8, 'Tucker Bridge.'),
(9, 'Dee (on the East Fork of the Hood).');

-- Waterfalls - note that height is in feet.
Insert Into Waterfalls (Name, SectionID, ClassID, Height, Description) Values
('Kahuna', 1, 10, '20', 'Kahuna (4+) is the single tallest drop on Canyon 
Creek and plunges 20 feet into a large pool. There is a class 3 lead-in rapid 
but a eddy on the river right at the lip allows for a scout and offers a good 
spot to stage for the drop. There is an obvious ramp on the right side of the 
falls where a delayed boof will yield a clean line. Both of the walls 
flanking the drop are somewhat undercut. There is no simple portage option so 
those not running the falls will need to toss their boats and jump. After the 
pool, there are a pair of class 3 rapids that can be junky at low water 
before the next horizon line of note.'),
('Champagne', 1, 10, '10', 'The Grand Finale of Canyon Creek is Champagne 
and Hammering Spot (4+), a sequence of two nearly perfect riverwide ledges 
both dropping 8-10 feet. Champagne can be run in a number of places but most 
will opt for the huge boof flake center left.'),
('Husum', 4, 9, '14', 'Husum Falls is the tallest commercially raftable 
waterfall in the U.S. Husum Falls is also located right along Highway 141 in 
the town of Husum, making it a very easy place for specters to gather and 
watch.'),
('Lava', 2, 11, '15', ' Lava Falls (5) is a 15 foot waterfall that can be 
scouted and portaged on the right side. There is a rope just up from the 
scout/portage ledge incase you need to climb out. It is possible to climb 
back into the canyon just above Triple Drop but it is very steep and requires 
some down climbing. Just below here the river goes through a narrow canyon 
that often has wood making it a bad place to swim.'),
('BZ Falls', 3, 11, '14', 'BZ Falls is by far the burliest drop on the 
White Salmon but lots of boaters run it these days. Three people have drowned 
here, all paddlers of some sort but no hard shell kayakers that I know of. 
All lost their lives when they ended up in the horrific hydraulic/undercut 
combination at the base of this falls. The lead-in to BZ is a fast 3+ drop 
with a sizable hole that you must run on the right in order to catch one of 
three small eddies just above the falls. Several paddlers have blown it here 
and been swept over the falls, so stay alert!'),
('Big Brother', 3, 11, '25', 'Big Brother is a drop that is commonly run 
at high flows and low flows... but in the medium flows is commonly walked. 
The danger is the cave that has claimed one life in the landing on the right. 
At low flows it is less in play and less consequential, at high flows you can 
go left. If you get to run it, the feeling of boofing as hard as you can from 
this height is quite fun. Scout either side, portage on the left.'),
('Double Drop', 3, '11', '18', 'Double Drop is a class 5 eighteen foot 
double falls that plunges down through two huge holes. Those not familiar 
with the river should be careful approaching the falls, especially when the 
river is high. There is a rapid leading right into Double Drop, so keep an 
eye out. Double Drop is usually pretty forgiving, unless you fall into it 
sideways. People who have run this drop have done so backwards, upside down, 
upside down and backwards, it is rare to get worked here.'),
('Little Brother', 3, 10, '15', 'Located just below Big Brother, Little 
Brother is a fun drop to do multiple laps on. In a modern high volume 
creekboat the falls can be run any way you want. That said, a paddler broke 
his boat on the bottom here back in the eighties so if you are paddling a 
longer old-style kayak you might want to boof with right angle.');

-- UserDoneSections
Insert Into UserDoneSections (UserID, SectionID, TimeCoordinates, Journal) 
Values
(1, 5, '2018-11-08', 'Awesome run! Had a great time. The first half of the 
run is a good warmup in preparation for the gorge. Only flipped once but 
got a roll in, no swims.'),
(1, 4, '2019-07-10', 'Extremely low water compared to when this baby can 
get flowing. Husum was a good reasonable level.'),
(1, 4, '2020-02-02', 'Wow! This is a completely different river when there 
is water in it. Amazing run.'),
(2, 7, '2019-06-20', 'Kicked this runs butt. I am a beast.'),
(2, 7, '2019-06-25', 'Still a legend of the sport. I need a harder 
challenge.'),
(2, 2, '2019-07-01', 'Got wrecked, lost my kayak, still out here. If you are 
reading this, please send help.');

-- UserDoneWaterfalls
Insert Into UserDoneWaterfalls (UserID, WaterfallID, TimeCoordinates, Journal) 
Values
(1, 3, '2019-07-10', 'Husum is a sweet drop! Was nervous but ended up doing 
several laps.');


-- SectionsCategories
Insert Into SectionsCategories (SectionID, SectionTypeID) Values
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(5, 3),
(6, 2),
(6, 4),
(6, 5),
(6, 6),
(7, 5),
(8, 2),
(8, 5),
(9, 2);

































