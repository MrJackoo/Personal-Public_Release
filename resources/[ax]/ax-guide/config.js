var config = {
  'title': '',

  'welcomeMessage': '',

  // Add images for the loading screen background.
  images: [
    'https://img.skordy.com/j/RGvCc.jpeg', 'https://img.skordy.com/j/nsQy5.jpeg', 'https://img.skordy.com/j/KNlLn.jpeg',
  ],

  // Turn on/off music
  enableMusic: true,
  // Music list. (Youtube video IDs). Last one should not have a comma at the end.
  music: [
    'vraG1S_SPAc', 'dBb060OPegg', 'VXUlwPSS-SQ', 'tgIqecROs5M'
  ],
  // Change music volume 0-100.
  musicVolume: 05,

  // Change Discord settings and link.
  'discord': {
    'show': true,
    'discordLink': 'DISCORD_INVITE_LINK',
  },

  // Change which key you have set in guidehud/client/client.lua
  'menuHotkey': 'F1',

  // Turn on/off rule tabs. true/false
  'rules': {
    'generalconduct': true,
    'roleplaying': true,
    'rdmvdm': true,
    'metagaming': true,
    'newlife': true,
    'combat': true,
    'abuse': true,
    'crims': false,
  },
}

// Home page annountments.
var announcements = [
  '',
]

// Add/Modify rules below.
var guidelines = [
  'You must respect each other at all times, toxicity or harassment will NOT be tolerated',
  'You are not permitted to sell or trade any in -game items or currency for real life money / items',
  'Microphones are required for gameplay.There are no exceptions',
  'While you can speak in various languages to your friends, you’re required to understand and speak English.If you don’t understand, you can’t play',
  'Your Character must be created with a realistic first and second name',
  ' - No using silly names, names of celebrities, well known criminals or terrorists etc(we reserve the right to ask you to make a new character if you break this rule!',
  'Not all rules can be listed so use common sense when playing',
  'Axiom strives to make itself a place people can call a safe place, sometimes, mistakes happen, we learn, we evolve, however, People that make unfounded accusations against axiom management that can also be construed as libel or slander can and will be removed from our services',
  ' - This is not limited to; insulting, accusations, and defamation',
  ' We don\'t appreciate those who join communities that are intended to cause harm, such as servers that steal files and or poach members',
  'If someone else is breaking rules, it doesn’t give you permission to break them in return.Stick to the rules, report them, rise above',
  'Advertising through stream links or names is not permitted without permission',
]

var generalconduct = [
  'Pillbox Hospital - This area is a safe zone, absolutely no crime is to take place in this area, medics are there to treat and save lives',
  'Hunting Area - No using any of the hunting equipment anywhere other than the hunting area',
  'Stay In Character At All Times - If there are any issues in-game complete the RP scenario then report afterwards, DO NOT go out of character',
  'Sexual/Inappropriate Roleplay - We absolutely do not allow any form of sexual assault, rape or other non-consensual roleplay, nor do we condone any similar behaviour mocking it. Anyone found in violation of this rule will receive a permanent ban without appeal',
  '',
  'Random Player Looting - Looting a player without sufficient RP is not allowed',
]

var roleplaying = [
  'Players must role-play every situation',
  '- Example: "I ran the stoplight because of server lag" or similar situations is not allowed',
  '- Exception:  Players may only go Out Of Character when a staff member asks you to explain a situation and/or authorizes you to go OOC',
  'Players must value their lives',
  '- Example:  If a player has a gun to their head they must act accordingly',
  'Players can not rule quote',
  'Players must role-play medical injuries correctly at all times',
  'Players can not enter an apartment to avoid consequences or role-play',
  'Players can not intentionally respawn, log out, or find another way to avoid or skirt potential role-play',
]

var rdmvdm = [
  'Players can not kill or attack other players without role-play',
  'Players must have a reason or a benefit to their character when trying to kill or attack another player',
  'Attacking someone without valid RP leading up to it is considered RDM (Random Death Match)',
  'Attacking someone with a vehicle without valid RP leading up to it is considered VDM(Vehicle Death Match)',
  'Using lethal force must be done with a high standard of roleplay',
]

var metagaming = [
  'Players can not use information gathered outside of role-play to influence their actions within the game',
  'Players may remove another players communication devices in an role-play manner',
  'Players with removed communication devices are expected to mute their third-party communication software',
  'Players may only remove another players communication device when it is logical within role-play',
  'Players can not use information gathered from outside the server (such as forums) while in-game',
  'Knowledge and experiences should be learned and discovered by a players current character in-game',
  'Players can not force another player into a situation that they cannot role-play out of. This is known as "Power-Gaming"',
  'Players must use common sense when encountering power-gaming potential situations',
]

var newlife = [
  'If you get downed and respawn at the Hospital you do not remember anything about what led up to your death',
  'You are not permitted to respawn at the hospital if you have been told the Police or NHS is on the way',
  'You are not permitted to respawn if you are shot by police and they are giving you medical attention and or waiting for the NHS to arrive',
  'You must at least attempt to call for the NHS if you get downed',
  'Having multiple characters in the same gang is not permitted',
  'If you roleplay that your character dies then you MUST follow through and delete your character (also know as perma-death)'
]

var combat = [
  'Combat Storing is not permitted: This can include storing your vehicle whilst being chased by criminals/police or driving your car into the water.',
  'Intentionally disconnecting from the game to avoid roleplay or consequences of roleplay can result in a ban. If your game crashes contact a staff member on discord asap.',
  'The act of teleporting such as logging out and logging back in to gain an in-game advantage, respawning to get to a different town faster is subject to disciplinary!'
]

var abuse = [
  'Players can not abuse or exploit bugs',
  'Players can not hack or script. (using third-party software, injectors, etc)',
  'Players who report an exploit using the proper procedures will be rewarded ingame',
  'Any attempts to exploit in-game mechanics/bugs, or using external software to gain an advantage will result in a permanent ban'
]

// CONTROLS TAB //

var generalhotkeys = [
  'Some of these settings can be customized by navigating in-game: Pressing ESC > SETTINGS > KEYBINDS > FIVEM',
  '<b>Customizable Keybinds</b>',
  '<kbd>F2</kbd> <kbd>F3</kbd> <kbd>F5</kbd> <kbd>F6</kbd> <kbd>F7</kbd> <kbd>F7</kbd> <kbd>F9</kbd> <kbd>F10</kbd> - Used for custom chat commands via /binds menu',
  'Press <kbd>Caps Lock</kbd> to talk over your radio (Must have a radio in your inventory)',
  'Press <kbd>Tab</kbd> to acess your inventory',
  'Press <kbd>G</kbd> to open the radial interaction menu',
  'Press <kbd>I</kbd> to open the hud menu',
  'Press <kbd>M</kbd> to open your phone',
  'Press <kbd>N</kbd> to use push to talk',
  'Press <kbd>Z</kbd> to cycle through the voice volumes (Whisper, Normal, Shouting)',
  '',
  '<b>Non-Customizable Keybinds</b>',
  'Press <kbd>B</kbd> to point your finger',
  'Press <kbd>Backspace</kbd> to go back in menus',
  'Press <kbd>E</kbd> to interact with various objects/menus/doors',
  'Press <kbd>Z</kbd> to cycle through the voice volumes (Whisper, Normal, Shouting)',
  'Press and hold <kbd>Left Alt</kbd> to use the "Third Eye" interaction option',
  'Press <kbd>T</kbd> to bring up the chat',
  'Press <kbd>X</kbd> to place your hands up',
]

var generalchat = [
  '<b>General Chat Commands</b>',
  'To use these commands simply press T, then enter the slash key / followed by the command, for example,/phone',
  'These commands can also be used in the F8 Menu if the chat is not working (Without the /)',
  '/999 - Message Police',
  '/bank - Check Bank Balance',
  '/binds  - Open commandbinding menu',
  '/cash - Check Cash Balance',
  '/divingsuit - Take off/put on your diving suit',
  '/givecarkeys [id] - Give Car Keys to a player ID',
  '/id - Check your ID (Paypal Number in RP)',
  '/me - Character interactions (Example /me picks up a newspaper)',
  '/radialmenu - Opens Radial Menu',
  '/engine - Toggles Engine On/Off',
]

var vehiclehotkeys = [
  '<b>Vehicle Controls</b>',
  'Press <kbd>-</kbd> to toggle left indicator',
  'Press <kbd>=</kbd> to toggle right indicator',
  'Press <kbd>B</kbd> to toggle your seatbelt',
  'Press <kbd>Backspace</kbd> to toggle your hazard lights',
  'Press <kbd>E</kbd> to activate your priority yelp (Police/NHS Only)',
  'Press <kbd>L</kbd> to lock/unlock your vehicle',
  'Press <kbd>LEFT ALT</kbd> to activate emergency sirens (Police/NHS Only)',
  'Press and Hold <kbd>LEFT ALT</kbd> to bring up the eye interaction options (Must be outside vehicle, use on parts of the vehicle, doors/engine etc)',
  'Press <kbd>Q</kbd> to activate emergency lights (Police/NHS Only)',
  'Press <kbd>R</kbd> to switch emergency siren tone (Police/NHS Only)',
]

var jobcommands = [
  '<b>Job Controls</b>',
  'Press <kbd>End</kbd> to bring up the multijob user interface',
  '',
  '<b>Misc Controls</b>',
  'Press <kbd>Home</kbd> to bring up the server scoreboard',
  'Press and hold <kbd>Delete</kbd> to bring up the player identifier options (Useful if you dont know your ID, or if needed for a player report)',
]

var interactions = [
  '<b>Eye Menu</b>',
  'Our server has an "eye" interaction feature that allows you to access certain menus or objects such as ATMs, shops, vehicles and more',
  'This option can be accessed by holding <kbd>LEFT ALT</kbd> then using your LEFT MOUSE BUTTON, LEFT CLICK on whichever option you need',
  '',
  '<b>Radial Menu</b>',
  'The radial menu feature is mainly used for self-interaction and for interacting with other players (such as giving contact details, using emotes, etc)',
  'This option can be accessed by pressing <kbd>G</kbd> , then using your MOUSE, navigate to whichever option you need and then pressing LEFT CLICK',
  '',
  '<b>Vehicle Control Menu</b>',
  'If you are inside a vehicle you can control multiple aspects of your vehicle, including toggling the engine, windows, changing seat and more',
  'To access the Vehicle Control Menu press your Radial Menu key-bind default <kbd>G</kbd>, click Vehicle and it will appear on-screen',
  '',
  '<b>Binds Menu</b>',
  'The binds menu allows you to customise your favourite chat commands to a select number of F keys',
  'To open the menu simply press <kbd>T</kbd and then type /binds',
  'To assign a key to a command type the command (without the /) into the command field and press SAVE BINDINGS',
  ' - For example, if I want to bind the toggle engine command to F2 I would type in engine and then I would save it.',
  '',
]

var emergency = [
  '<b>Prop System</b>',
  'Delete prop (In Hand) - <kbd>BACKSPACE</kbd>', ,
  'Open Menu(Next to Police/NHS Vehicle) <kbd>NUMPAD -</kbd>',
  'Pickup/Drop Prop - <kbd>NUMPAD +</kbd>',
  'Move Object Keys',
  'Move North, South, West or East = <kbd>↑</kbd> <kbd>↓</kbd> <kbd>←</kbd> <kbd>→</kbd>',
  'Lower = <kbd>PAGEDOWN</kbd>',
  'Rotate = <kbd>INSERT</kbd>',
  'PlaceDown = <kbd>ENTER</kbd>',
  'Exit = <kbd>BACKSPACE</kbd>',
]

// JOBS TAB //

var cityhall = [
  '<b>City Hall Jobs</b>',
  'All the following jobs can be picked up from City Hall and each job grants you a basic salary and varying amounts of money for completing job tasks',
  'If you are unsure on how to get to City Hall then press <kbd>T</kbd> and type in /cityhall , this will give you a waypoint that will show on your map and minimap (inside a vehicle)',
  ' - Bus Driver',
  ' - Garbage Collector',
  ' - Taxi Driver',
  ' - Tow-Truck Driver',
  '',
  '<b>Get Employed</b>',
  'Once inside walk up to the main desk use your <kbd>E</kbd> key to bring up the City Hall Menu, then select a job to start your employment',
  '   - If you check your map you will see a waypoint marked that shows you where the job is started, head to that location!',
  '',

]

var legaljobs = [
  '<b>Legal Jobs</b>',
  'There are a number of jobs throughout Los Santos that can earn you some good money, these jobs are usually taken at their unique locations.',
  'These jobs can be located on your main map with their respective "blips", or you can ask other citizens in the city',
  ' - Diving',
  ' - Fishing',
  ' - GoPostal',
  ' - Hunting',
  ' - Mining',
  '',
]

var emergencyservices = [
  '<b>Los Santos Police</b>',
  'The Los Santos Police is tasked with dealing with crime and disorder, and to protect the welfare of all citizens of Los Santos',
  '',
  '<b>Los Santos National Health Service</b>',
  'The Los Santos National Health Service is a public healthcare organisation that deals with the health and welfare of all citizens of Los Santos',
  '',
]

// HELP TAB //

var vehiclehelp = [
  '<b>Vehicle Help</b>',
  'Where can i buy a vehicle?',
  ' - Vehicles can be bought freely at PDM (/axpdm to set a waypoint)',
  ' - Import/Custom cars are sold at Tuners by Car Dealers (/axtuners to set a waypoint)',
  '',
  'Where do i store/retrieve vehicles?',
  ' - Your vehicles can stored or retrieved at any garage (marked on the map with a garage symbol)',
  ' - To store/retrieve simply go to a garage, access the radial menu, default <kbd>G</kbd> then open garage',
  '',
  'My car is missing',
  ' - Your car may be in a different garage than you think, check the vehicle app on your phone for your vehicles status,',
  ' - If your vehicle status is not In or Garaged then it may be in the impound or seized by police (/aximpound or /axpolice to set a waypoint)',
  '',
]

var common = [
  '<b>Common Questions and Answers</b>',
  'Is the server whitelisted ?',
  ' - No, anyone can join with the exceptions of those who are banned in our community for hacking or are community banned etc',
  'Do you have Police and Medics ?',
  ' - Yes,',
  'Are there donator perks ?',
  ' - Soon, we are still working out the details',
  'Do you allow client - side modifications ?',
  ' - We allow ONLY allow visual and sound modifications, such as enhanced graphics, brighter lights or custom gun sounds',
  ' - Anyone found to be using custom menus, injectors or hacks will receive a permanent ban without appeal',
  '',
]

var gamehelp = [
  '<b>OOC</b>',
  'Out of Character Chat(OOC) can be used to ask support related questions, you can use OOC by pressing T and typing /ooc followed by your question',
  ' - We highly recommend you check out this wiki before asking',
  ' - OOC is NOT a chat room and anyone using it to chat or use for metagaming will be warned and possibly banned',
  '',
  '<b>In-Game Fixes</b>',
  'We have implemented some in-game chat <kbd>T</kbd> commands that can help fix a number of UI and game issues',
  '/propstuck - Removes any props stuck to your character',
  '/reset - Revert clothing back to normal',
  '/quit - Closes FiveM',
  '',
  'If the above commands do not help then a restart is your best option, however, in some cases, you may need to wait for a server restart although this is only on very rare occasions',
]

var cache = [
  '<b>Client Cache Fixes</b>',
  'If you experience constant issues even after multiples game restarts, through server restarts and there are no reported server issues then clearing your cache may help',
  'Please note that you should rarely ever need to do this, and this is only intended if you can\'t fix your issues',
  '',
  '<b>Instructions:</b> (BEFORE clearing your cache check the discord/website to check if there is a server issue or outage)',
  'Copy these instructions to word or notepad, BEFORE closign FiveM!!!',
  ' - Close FiveM',
  ' - Browse to your local AppData folder (Hold Windows + R and type in % localappdata %)',
  ' - Navigate into FiveM > FiveM Application Data > data',
  ' - Delete ONLY the cache and the server - cache - priv folders(if you delete more than this you will have to redownload missing files or data)',
  ' - Launch your FiveM client, your issues should be hopefully fixed',
  ''
]

var reportaplayer = [
  '<b>Report a Player</b>',
  'In an ideal world, everyone on the server would roleplay to their full potential, however, there are some players who will break rules intentionally, and some who will go out there way to disrupt RP and players enjoyment',
  'This does not mean you should report every player who breaks a rule, some players may break a rule by accident, or do so unintentionally and we strongly recommend you try and resolve with the player via voice on our TeamSpeak or Discord Server',
  '',
  'A good tool to use for recording is Windows 10 Bult-in Game Bar, there are several guides online in how to set this up for FiveM',
  '',
  'To gather a players licence key (top) and session ID (bottom) press and hold <kbd>DELETE</kbd> (Any abuse of this WILL result in a ban)',
  'If you wish to report a player then fill in the report a player form on our website',
  '',
  ' - You MUST include video evidence of at least 3 minutes leading up to the rule break, including the rule break in the video',
  ' - You MUST include the player\'s session ID',
  ' - Include as much information as possible',
  ' - Must not be a revenge report',
  ' - Evidence must not be edited',
  '',
  'You can submit a report here',
]

var links = [
  '<b>Check Out Our Tebex!</b>',
  'https://axiom-roleplay.tebex.io/'
]