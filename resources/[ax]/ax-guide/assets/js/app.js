document.addEventListener('DOMContentLoaded', function () {
  document.querySelector('.navbar-brand').innerHTML = config.title;
  document.querySelector('#pills-home h1').innerHTML = config.welcomeMessage;
  document.querySelector('#pills-home h2 kbd').innerHTML = config.menuHotkey;

  announcementItem();
  ruleItems();
  hotkeyItems();
});

function loadingScreen() {
  slider();
  cursor();
  community();
}

function slider() {
  var background = document.getElementById('background');

  config.images.forEach(function (image) {
    var img = document.createElement('img');

    img.src = image;
    background.appendChild(img);
  });

  var current = 0;
  var slides = background.childNodes;

  setInterval(function () {
    for (var i = 0; i < slides.length; i++) {
      slides[i].style.opacity = 0;
    }
    current = (current != slides.length - 1) ? current + 1 : 0;
    slides[current].style.opacity = 1;
  }, 5000);
}

function announcementItem() {
  var announcementList = document.querySelector('#pills-home ul');

  announcements.forEach(function (announcement) {
    var li = document.createElement('li');

    li.textContent = announcement;
    announcementList.appendChild(li);
  });
}

function community() {
  if (config.discord.show == true) {
    document.querySelector('.discord p').innerHTML = config.discord.discordLink;
  } else {
    document.querySelector('.discord').style.display = 'none';
  }
}

function ruleItems() {
  var guidelineList = document.querySelector('#v-pills-guidelines');
  var generalconductList = document.querySelector('#v-pills-general-conduct');
  var roleplayingList = document.querySelector('#v-pills-chatrules');
  var rdmvdmList = document.querySelector('#v-pills-rdmvdm');
  var metagamingList = document.querySelector('#v-pills-meta-powergaming');
  var newlifeList = document.querySelector('#v-pills-newlife');
  var combatList = document.querySelector('#v-pills-combat');
  var abuseList = document.querySelector('#v-pills-exploits');
  var crimsList = document.querySelector('#v-pills-crims');

  guidelines.forEach(function (item) {
    var p = document.createElement('p');

    p.textContent = item;
    guidelineList.appendChild(p);
  });

  if (config.rules.generalconduct == true) {
    generalconduct.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      generalconductList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-general-conduct-tab').style.display = 'none';
  }

  if (config.rules.roleplaying == true) {
    roleplaying.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      roleplayingList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-chatrules-tab').style.display = 'none';
  }

  if (config.rules.rdmvdm == true) {
    rdmvdm.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      rdmvdmList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-rdmvdm-tab').style.display = 'none';
  }

  if (config.rules.metagaming == true) {
    metagaming.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      metagamingList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-meta-powergaming-tab').style.display = 'none';
  }

  if (config.rules.newlife == true) {
    newlife.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      newlifeList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-newlife-tab').style.display = 'none';
  }

  if (config.rules.combat == true) {
    combat.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      combatList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-combat-tab').style.display = 'none';
  }

  if (config.rules.abuse == true) {
    abuse.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      abuseList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-exploits-tab').style.display = 'none';
  }

  if (config.rules.crims == true) {
    crims.forEach(function (item) {
      var p = document.createElement('p');

      p.textContent = item;
      crimsList.appendChild(p);
    });
  } else {
    document.getElementById('v-pills-crims-tab').style.display = 'none';
  }
}

function hotkeyItems() {
  var generalhotkeyList = document.querySelector('#v-pills-general');
  var generalchatList = document.querySelector('#v-pills-chat');
  var vehiclehotkeyList = document.querySelector('#v-pills-vehicles');
  var jobhotkeyList = document.querySelector('#v-pills-jobs');
  var interactionshotkeyList = document.querySelector('#v-pills-interactions');
  var emergencyhotkeyList = document.querySelector('#v-pills-emergency')
  var cityhallhotkeyList = document.querySelector('#v-pills-cityhall');
  var legalhotkeyList = document.querySelector('#v-pills-legaljobs');
  var emergencyserviceshotkeyList = document.querySelector('#v-pills-emergencyservices');
  var commonhotkeyList = document.querySelector('#v-pills-common');
  var gamehelphotkeyList = document.querySelector('#v-pills-gamehelp');
  var cachehotkeyList = document.querySelector('#v-pills-cache');
  var reportaplayerhotkeyList = document.querySelector('#v-pills-reportaplayer');
  var linkshotkeyList = document.querySelector('#v-pills-links');
  var vehiclehelphotkeyList = document.querySelector('#v-pills-vehiclehelp');

  generalhotkeys.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    generalhotkeyList.appendChild(p);
  });

  generalchat.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    generalchatList.appendChild(p);
  });

  vehiclehotkeys.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    vehiclehotkeyList.appendChild(p);
  });

  jobcommands.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    jobhotkeyList.appendChild(p);
  });

  interactions.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    interactionshotkeyList.appendChild(p);
  });

  emergency.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    emergencyhotkeyList.appendChild(p);
  });

  cityhall.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    cityhallhotkeyList.appendChild(p);
  });

  legaljobs.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    legalhotkeyList.appendChild(p);
  });

  emergencyservices.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    emergencyserviceshotkeyList.appendChild(p);
  });

  common.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    commonhotkeyList.appendChild(p);
  });

  gamehelp.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    gamehelphotkeyList.appendChild(p);
  });

  cache.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    cachehotkeyList.appendChild(p);
  });

  reportaplayer.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    reportaplayerhotkeyList.appendChild(p);
  });

  links.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    linkshotkeyList.appendChild(p);

  });

  vehiclehelp.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    vehiclehelphotkeyList.appendChild(p);

  });
}

function cursor() {
  document.body.addEventListener("mousemove", function (event) {
    var x = event.pageX - 6 + "px"
    var y = event.pageY + "px"
    document.getElementById("cursor").style.left = x;
    document.getElementById("cursor").style.top = y;
  })
};