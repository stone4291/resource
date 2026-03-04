ChoosedButton = 0
InSubMenu = false
SignalRotation = 324000
ChangingText = false
SubNumber = null
EditButton = ''
ControlMode = 2
InPanelEdit = false
CanChangePage = true
let mouseMoveHandler

if (localStorage.getItem("ControlMode") === null){
  localStorage.setItem("ControlMode", JSON.stringify(ControlMode));
}

ControlMode = JSON.parse(localStorage.getItem("ControlMode"))
document.getElementById("control_"+ControlMode).classList.add("hovered")
$.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"control_mode", mode:ControlMode}))

window.addEventListener('message', function(event) {
    let data = event.data

    if (data.action === "OpenGangJobMenu"){
      InteractionsTable = data.interactionstable
      Background = data.background
      EditButton = data.editbutton[0]
      $(".hint .button_to_press").html(data.editbutton[1])
      document.querySelector(':root').style.setProperty('--main_color', data.panelcolor)
      CreateJobMenu()
      $(".hint").css("display","flex")
      document.getElementById('hint').style.animation = "showmenu 0.3s ease both";
    }
    else if (data.action === "ChangeFocus"){
      ChangeFocus(data.type)
    }
    else if (data.action === "ChooseBTN"){
      document.getElementById("circle_"+ChoosedButton).click()
    }
    else if (data.action === "PanelEdit"){
      hide('hint')
      show('controlling_choose')
      InPanelEdit = true
    }
    else if (data.action === "BlackFade"){
      if (data.value){
        show('black_fade')
      }
      else{
        hide('black_fade')
      }
    }
    else if (data.action === "Hostage"){
      $(".hostage").css("display", "block")
      $(".hostage").css("animation", "hostage_anim 0.8s ease-in-out both")
    }
    else if (data.action === "HideHostage"){
      $(".hostage").css("animation", "hostage_anim_reverse 0.8s ease-in-out both")
      setTimeout(() => {
        $(".hostage").css("display", "none")
      }, 500);
    }
    else if (data.action === "close"){
      if (!InSubMenu){
        $(".circles_label").css("animation", "")
        Close()
      }
      else{
        document.getElementById("openup_anim").style.animation = "center_closeup 0.5s ease";
        CreateJobMenu()
      }
    }
})

document.onkeydown = function(data) {
  if (event.key == 'Escape') {
    window.postMessage({action : "close"}, '*');
  }
  else if (event.key == EditButton) {
    window.postMessage({action : "PanelEdit"}, '*');
  }
}

function Close(){
  document.getElementById("openup_anim").style.animation = "none";
  DeleteEvents()
  HideJobMenu()
  hide('controlling_choose')
  hide('hint')
  $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"close"}))
}

function ChangeControlMode(id, mode){
  document.getElementById("control_1").classList.remove("hovered")
  document.getElementById("control_2").classList.remove("hovered")
  document.getElementById("control_3").classList.remove("hovered")
  document.getElementById(id).classList.add("hovered")

  localStorage.setItem("ControlMode", JSON.stringify(mode));
  $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"control_mode", mode}))
  Close()
  setTimeout(() => {
    InPanelEdit = false
  }, 400);
}

document.addEventListener("click", (event) => {
  if (!InPanelEdit && ControlMode !== 3){
    document.getElementById("circle_"+ChoosedButton).click()
  }
});

function ChangeFocus(direction, mouse){
  if (!mouse){
    if(direction === "up"){
      SignalRotation = SignalRotation-MenuBTNRot
      if(InSubMenu === false){
        if(InteractionsTable.length >= ChoosedButton +2){
          ChoosedButton++
        }
        else if(InteractionsTable.length === ChoosedButton +1){
          ChoosedButton = 0
        }
      }
      else{
        if(InteractionsTable[SubNumber].table.length > ChoosedButton + 1){
          ChoosedButton++
        }
        else if(InteractionsTable[SubNumber].table.length === ChoosedButton +1){
          ChoosedButton = 0
        }
      }
    }
    else{
      SignalRotation = SignalRotation+MenuBTNRot
      if(InSubMenu === false){
        if(ChoosedButton === 0){
          ChoosedButton = InteractionsTable.length -1
        }
        else{
          ChoosedButton = ChoosedButton -1
        }
      }
      else{
        if(ChoosedButton === 0){
          ChoosedButton = InteractionsTable[SubNumber].table.length -1
        }
        else{
          ChoosedButton = ChoosedButton -1
        }
      }
    }
  }
  else{
    if (ChoosedButton < direction) {
      if (ChoosedButton === 0 && direction === Num_elements-1){
        SignalRotation = SignalRotation+MenuBTNRot
      }
      else{
        SignalRotation = SignalRotation-MenuBTNRot
      }
    }
    else if (ChoosedButton > direction) {
      if (ChoosedButton === Num_elements-1 && direction === 0){
        SignalRotation = SignalRotation-MenuBTNRot
      }
      else{
        SignalRotation = SignalRotation+MenuBTNRot
      }
    } 

    if (Math.abs(SignalRotation % 360) != (360 - direction * MenuBTNRot) % 360) {
      let baseRotation = SignalRotation - SignalRotation % 360;  
  
      if (SignalRotation < 0) {  
          SignalRotation = (360 - direction * MenuBTNRot) + baseRotation;
      } else {  
          SignalRotation = (360 - direction * MenuBTNRot) + baseRotation;
      }
    }  

    ChoosedButton = direction
  }
  

  if(InSubMenu){
    for(let i=0; i<InteractionsTable[SubNumber].table.length; i++){
      document.getElementById("circle_"+i).classList.remove("hovered_circle")
    }
    Circle_Label = InteractionsTable[SubNumber].table[ChoosedButton].label
    Circle_Description = InteractionsTable[SubNumber].table[ChoosedButton].description
  }
  else{
    for(let i=0; i<InteractionsTable.length; i++){
      document.getElementById("circle_"+i).classList.remove("hovered_circle")
    }
    Circle_Label = InteractionsTable[ChoosedButton].label
    Circle_Description = InteractionsTable[ChoosedButton].description
  }

  $(".rotating_con").css("transform", "translate(-50%, -50%) rotate("+SignalRotation+"deg)")
  document.getElementById("circle_"+ChoosedButton).classList.add("hovered_circle")

  if (document.getElementById("circle_"+ChoosedButton).disabled){
    ChangeFocus(direction)
  }

  $(".circles_label").css("display", "none")
  if (direction == 'up'){
    $(".circles_label").css("animation", "text_anim 0.3s")
  }
  else{
    $(".circles_label").css("animation", "text_anim 0.3s reverse")
  }
  
  setTimeout(() => {
    $(".circles_label").css("display", "block")
  }, 8);
  
  if (!ChangingText){
    setTimeout(() => {
      ChangingText = false
      $(".circles_label").html(Circle_Label)
    }, 150);
  }
  else{
    $(".circles_label").html('')
  }
  ChangingText = true
  $(".circles_description").html(Circle_Description)
}

function DeleteEvents(){
  if (SubNumber != null){
    document.removeEventListener("mousemove", mouseMoveHandler);
    SubNumber = null
  }
  else{
    document.removeEventListener("mousemove", mouseMoveHandler);
  }
}

function CreateJobMenu(){
  if (CanChangePage){
    InSubMenu = false
    Num_elements = InteractionsTable.length
    let Angle = Math.ceil(360/Num_elements)
    let Rot = -90
    ChoosedButton = 0
    MenuBTNRot = Angle
    CanChangePage = false
  
    // Panel showing
    if (Background){
      show('plugin')
    }
    else{
      $(".center_circle").css("backdrop-filter", "none")
    }
    setTimeout(() => {
      $(".job_menu").css("animation", "none")
      $(".job_menu").css("display","block")
    }, 100);
  
    // Submenu events removal
    if (SubNumber != null){
      document.removeEventListener("mousemove", mouseMoveHandler);
      SubNumber = null
    }
 
  
    setTimeout(() => {
      CircleElementsTable = []
      $(".circle_container").html("")
      for(let i=0; i<Num_elements; i++){
        if (InteractionsTable[i].table == undefined){
          if (InteractionsTable[i].use !== false && InteractionsTable[i].apper !== false) {
            $(".circle_container").append(`
              <button class="circle_element" id="circle_${i}" onclick="SendBackIntButton(id, false)">${InteractionsTable[i].icon}
              <div class="bg_color"></div>
              </button>
            `)
          }
        }
        else{
          $(".circle_container").append(`
            <button class="circle_element" id="circle_${i}" onclick="ChangeJobButtons(id)">${InteractionsTable[i].icon}
            <div class="bg_color"></div>
            <div class="sub_elements_con"></div>
            </button>
          `)
          for(let _i=0; _i<InteractionsTable[i].table.length; _i++){
            $(`.circle_container #circle_${i} .sub_elements_con`).append(`
              <div class="sub_elements_dot"></div>
            `)
          }
        }
    
        $(".job_menu #circle_"+i).css("transform", "rotate("+Rot+"deg) translate(120px) rotate("+Rot*(-1)+"deg)")
        $(".job_menu #circle_"+i).css("animation", "circle_element 0.5s ease "+i*0.05+"s both")
        Rot = Rot - Angle
        
      }

      mouseMoveHandler = (event) => {
        MouseMoveEvent(InteractionsTable);
      };
      document.addEventListener("mousemove", mouseMoveHandler);
    
      document.getElementById("circle_"+ChoosedButton).classList.add("hovered_circle")
      $(".circles_label").html(InteractionsTable[0].label)
      $(".circles_description").html(InteractionsTable[0].description)
      SignalRotation = 324000
      $(".rotating_con").css("transform", "translate(-50%, -50%) rotate("+SignalRotation+"deg)")
      CanChangePage = true
    }, 100);
  }
}

function ChangeJobButtons(id){
  if (CanChangePage){
    InSubMenu = true
    CanChangePage = false
  
    SubNumber = id.split('_').pop();
    Num_elements = InteractionsTable[SubNumber].table.length
    let Angle = Math.round(360/Num_elements)
    let Rot = -90
    MenuBTNRot = Angle
  
    document.getElementById("openup_anim").style.animation = "center_openup 0.5s ease";
  
    // Main elements event removal
    document.removeEventListener("mousemove", mouseMoveHandler);

    setTimeout(function(){
      $(".circle_container").html("")
      for(let i=0; i<Num_elements; i++){
  
        $(".circle_container").append(`
          <button class="circle_element" id="circle_${i}" onclick="SendBackIntButton(id, true)">${InteractionsTable[SubNumber].table[i].icon}
          <div class="bg_color"></div>
          </button>
        `)
  
        $(".job_menu #circle_"+i).css("transform", "rotate("+Rot+"deg) translate(120px) rotate("+Rot*(-1)+"deg)")
        $(".job_menu #circle_"+i).css("animation", "circle_element 0.5s ease "+i*0.05+"s both")
        Rot = Rot - Angle

      }

      mouseMoveHandler = (event) => {
        MouseMoveEvent(InteractionsTable[SubNumber].table);
      };
      document.addEventListener("mousemove", mouseMoveHandler);
  
      ChoosedButton = 0
      document.getElementById("circle_"+ChoosedButton).classList.add("hovered_circle")
      $(".circles_label").html(InteractionsTable[SubNumber].table[0].label)
      $(".circles_description").html(InteractionsTable[SubNumber].table[0].description)
      SignalRotation = 324000
      $(".rotating_con").css("transform", "translate(-50%, -50%) rotate("+SignalRotation+"deg)")
      CanChangePage = true
    },100)
  }
}

function HideJobMenu(){
  $(".job_menu").css("animation", "ScaleDown 0.4s ease-in-out both")
  hide('plugin')
  setTimeout(function(){
    $(".job_menu").css("display","none")
  },250)
}

function SendBackIntButton(id, value){
  let idnumber = id.split('_').pop()
  
  if (value == true){
    if (SubNumber != null && InteractionsTable[SubNumber].table[idnumber]?.event !== undefined) {
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"event", event:InteractionsTable[SubNumber].table[idnumber].event}))
      Close()
    } 
    else if (SubNumber != null && InteractionsTable[SubNumber].table[idnumber]?.cmd !== undefined) {
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"cmd", cmd:InteractionsTable[SubNumber].table[idnumber].cmd}))
      Close()
    }
  }
  else if (value == false){
    if (InteractionsTable[idnumber]?.event !== undefined) {
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"event", event:InteractionsTable[idnumber].event}))
      Close()
    } 
    else if (InteractionsTable[idnumber]?.cmd !== undefined) {
      $.post('https://'+GetParentResourceName()+'/UseButton', JSON.stringify({action:"cmd", cmd:InteractionsTable[idnumber].cmd}))
      Close()
    }
  }
}

function MouseMoveEvent(table){
  for(let i=0; i<table.length; i++){
    if (document.getElementById('circle_'+i) != null){
      const rect = document.getElementById('circle_'+i).getBoundingClientRect();
      const elementCenterX = rect.left + rect.width / 2;
      const elementCenterY = rect.top + rect.height / 2;
    
      const mouseX = event.clientX;
      const mouseY = event.clientY;
    
      const distance = Math.sqrt(
        Math.pow(mouseX - elementCenterX, 2) + Math.pow(mouseY - elementCenterY, 2)
      );
    
      CircleElementsTable.push(distance)
    }
  }
 

  if (CircleElementsTable.length == Num_elements){
    let smallestNumber = CircleElementsTable[0];
    let smallestIndex = 0;

    for (let i = 1; i < CircleElementsTable.length; i++) {
      if (CircleElementsTable[i] < smallestNumber) {
        smallestNumber = CircleElementsTable[i];
        smallestIndex = i;
      }
    }

    if (ChoosedButton != smallestIndex){
      ChangeFocus(smallestIndex, true)
    }
  
    CircleElementsTable = []
  }
}

/////////////////////////////////////////////////////////////// BASIC FUNCTIONS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

function show(element){
  $("#"+element).css("display","block")
  document.getElementById(element).style.animation = "showmenu 0.3s ease both";
}

function hide(element){
  document.getElementById(element).style.animation = "hidemenu 0.3s ease";
  setTimeout(function(){
    $("#"+element).css("display","none")
  }, 300)
}

function isNumber(evt) {
  evt = (evt) ? evt : window.event
  var charCode = (evt.which) ? evt.which : evt.keyCode
  if (charCode > 31 && (charCode < 48 || charCode > 57)) {
      return false
  }
  return true
}

function setlenght(id) {
  if (document.getElementById(id).value.length === 2 && document.getElementById(id).value[0] == 0){
    document.getElementById(id).value = document.getElementById(id).value.substring(1)
  }
  if (document.getElementById(id).value.length === 4){
    document.getElementById(id).value = document.getElementById(id).value.substring(1)
  }
  if (document.getElementById(id).value.length === 0){
    document.getElementById(id).value = 0
  }
  changemoney()
  return true
}

function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

  elmnt.onmousedown = dragMouseDown;

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();

    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();

    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;

    elmnt.style.opacity = "0.8"

    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    elmnt.style.opacity = "1"
    document.onmouseup = null;
    document.onmousemove = null;
  }
}

function elementsOverlap(el1, el2) {
  const domRect1 = el1.getBoundingClientRect();
  const domRect2 = el2.getBoundingClientRect();

  return !(
    domRect1.top+50 > domRect2.bottom ||
    domRect1.right-50 < domRect2.left ||
    domRect1.bottom-50 < domRect2.top ||
    domRect1.left+50 > domRect2.right
  );
}

function GetTime(createdtime){
  let time = Math.round(Date.now() / (1000 * 60)) - createdtime
  return time
}

function fancyTimeFormat(duration)
{   
    var hrs = ~~(duration / 3600);
    var mins = ~~((duration % 3600) / 60);
    var secs = ~~duration % 60;

    var ret = "";

    if (hrs > 0) {
        ret += "" + hrs + ":" + (mins < 10 ? "0" : "");
    }

    ret += "" + mins + ":" + (secs < 10 ? "0" : "");
    ret += "" + secs;
    return ret;
}
