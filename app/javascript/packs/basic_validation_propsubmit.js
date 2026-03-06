

document.addEventListener("turbolinks:load", function () {

  const stepFields = {
    step1: ['name', 'price', 'phonenumber'],
    step2: ['description','address','state','city','status','completiondate','bedroom','bathroom','area'],
    step3: ['videoone','videotwo'],
    step4: ['terms']
  };

  const nextBtn = document.querySelector(".btn-next");
  const finishBtn = document.querySelector(".btn-finish");

  const tabs = document.querySelectorAll('[data-toggle="tab"]');

  //-------------------------------------
  // GET INPUT
  //-------------------------------------

  function getInput(field){
    if(field === "terms"){
      return document.getElementById("terms");
    }
    return document.getElementById(`property_${field}`);
  }

  //-------------------------------------
  // VALIDATE STEP
  //-------------------------------------

  function validateStep(stepId){

    const fields = stepFields[stepId];

    for(let field of fields){

      const input = getInput(field);

      if(!input) continue;

      if(input.type === "checkbox"){
        if(!input.checked) return false;
      }else{
        if(input.value.trim() === "") return false;
      }

    }

    return true;
  }

  //-------------------------------------
  // CURRENT STEP
  //-------------------------------------

  function getCurrentStep(){
    const active = document.querySelector(".tab-pane.active");
    return active ? active.id : null;
  }

  //-------------------------------------
  // UPDATE BUTTONS
  //-------------------------------------

  // function updateButtons(){

  //   const stepId = getCurrentStep();

  //   if(!stepId) return;

  //   const valid = validateStep(stepId);

  //   if(stepId === "step4"){

  //     nextBtn.style.display="none";
  //     finishBtn.style.display="inline-block";
  //     finishBtn.disabled = !valid;

  //   }else{

  //     nextBtn.style.display="inline-block";
  //     finishBtn.style.display="none";
  //     nextBtn.disabled = !valid;

  //   }

  // }

  function updateTabs() {

  const steps = Object.keys(stepFields);

  steps.forEach((stepId, index) => {

    const tab = document.querySelector(`a[href="#${stepId}"]`);

    if (!tab) return;

    // Step 1 should always stay enabled
    if (index === 0) {
      tab.classList.remove("disabled");
      tab.style.pointerEvents = "auto";
      return;
    }

    const prevStep = steps[index - 1];

    if (validateStep(prevStep)) {
      tab.classList.remove("disabled");
      tab.style.pointerEvents = "auto";
    } else {
      tab.classList.add("disabled");
      tab.style.pointerEvents = "none";
    }

  });

}

function updateButtons() {

  const stepId = getCurrentStep();

  if (!stepId) return;

  const valid = validateStep(stepId);

  if (stepId === "step4") {

    // Hide Next button
    if (nextBtn) nextBtn.style.display = "none";

    // Show Finish button
    if (finishBtn) {
      finishBtn.style.display = "inline-block";
      finishBtn.disabled = !valid;
    }

  } else {

    // Show Next button
    if (nextBtn) {
      nextBtn.style.display = "inline-block";
      nextBtn.disabled = !valid;
    }

    // Hide Finish button
    if (finishBtn) {
      finishBtn.style.display = "none";
    }

  }

  // Update tabs state
  updateTabs();

}

  //-------------------------------------
  // DISABLE TABS INITIALLY
  //-------------------------------------

  tabs.forEach((tab,index)=>{

    if(index !== 0){
      tab.classList.add("disabled");
      tab.style.pointerEvents="none";
    }

  });

  

  //-------------------------------------
  // PREVENT TAB CLICK
  //-------------------------------------

  tabs.forEach(tab=>{

    tab.addEventListener("click",function(e){

      if(this.classList.contains("disabled")){
        e.preventDefault();
      }

    });

  });

  //-------------------------------------
  // TAB CHANGE
  //-------------------------------------

  tabs.forEach(tab => {

    tab.addEventListener("shown.bs.tab", function () {
      updateButtons();
    });

  });

  //-------------------------------------
  // INSTANT INPUT LISTENER
  //-------------------------------------

  document.addEventListener("keyup", updateButtons);
  document.addEventListener("change", updateButtons);
  document.addEventListener("blur", updateButtons, true);

  //-------------------------------------
  // SAFETY CHECK (NO DELAY FEEL)
  //-------------------------------------

  setInterval(updateButtons, 100);

  //-------------------------------------
  // INITIAL
  //-------------------------------------

  updateButtons();

});