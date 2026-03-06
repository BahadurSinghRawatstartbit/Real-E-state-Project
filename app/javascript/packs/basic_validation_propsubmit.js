document.addEventListener("turbolinks:load", function () {

  const stepFields = {
    step1: ['name', 'price', 'phonenumber'],
    step2: ['description', 'address', 'state', 'city', 'status', 'completiondate', 'bedroom', 'bathroom', 'area'],
    step3: ['videoone', 'videotwo'],
   
  };


  // const nextBtn = document.querySelector(".btn-next");

  // // get step 1 inputs using your stepFields
  // const step1Inputs = stepFields.step1.map(field =>
  //   document.getElementById(`property_${field}`)
    
  // );

  // function validateStep1() {
  //   return step1Inputs.every(input => input.value.trim() !== "");
  // }

  // // initially disable Next
  // nextBtn.disabled = true;

  // // listen for changes
  // step1Inputs.forEach(input => {
  //   input.addEventListener("input", function () {
  //     alert(this.value); // as you requested

  //     nextBtn.disabled = !validateStep1();
  //   });
  // });


  //  const nextBtn   = document.querySelector(".btn-next");
  // const finishBtn = document.querySelector(".btn-finish");

  // function getCurrentStep() {
   
  //   return document.querySelector(".tab-pane.active").id;
  // }

  // function getInputs(stepId) {
  //   return stepFields[stepId].map(field => {
  //     if (field === "terms") {
  //       return document.getElementById("terms");
  //     }
  //     return document.getElementById(`property_${field}`);
  //   });
  // }

  // function isValid(stepId) {
  //   return getInputs(stepId).every(input => {
  //     if (!input) return false;
  //     return input.type === "checkbox"
  //       ? input.checked
  //       : input.value.trim() !== "";
  //   });
  // }

  // function handleChange(e) {
  //   // alert(e.target.type === "checkbox" ? e.target.checked : e.target.value);

  //   const step = getCurrentStep();
  //   // alert(step);
  //   nextBtn.disabled   = !isValid(step);
  //   finishBtn.disabled = !isValid(step);
    
  // }

  // // Attach listeners ONCE to all inputs
  // Object.keys(stepFields).forEach(step => {
  //   getInputs(step).forEach(input => {
  //     if (!input) return;
  //     input.addEventListener("input", handleChange);
  //     input.addEventListener("change", handleChange);
  //   });
  // });

  // // Initial state
  // nextBtn.disabled = true;
  // finishBtn.disabled = true;




   const nextBtn   = document.querySelector(".btn-next");
  const finishBtn = document.querySelector(".btn-finish");

  // -------------------------------
  // GET CURRENT STEP ID
  // -------------------------------
  function getCurrentStep() {
    return document.querySelector(".tab-pane.active").id;
  }

  // -------------------------------
  // VALIDATE STEP (VISIT EVERY INPUT)
  // -------------------------------
  function validateStep(stepId) {

    let isValid = true;
    const fields = stepFields[stepId];

    for (let i = 0; i < fields.length; i++) {

      let fieldName = fields[i];
      let input;

      if (fieldName === "terms") {
        input = document.getElementById("terms");
      } else {
        input = document.getElementById(`property_${fieldName}`);
      }

      // input missing
      if (!input) {
        isValid = false;
        break;
      }

      // checkbox validation
      if (input.type === "checkbox") {
        if (!input.checked) {
          isValid = false;
          break;
        }
      }
      // text / date / select validation
      else {
        if (input.value.trim() === "") {
          isValid = false;
          break;
        }
      }
    }

    return isValid;
  }

  // -------------------------------
  // UPDATE BUTTON STATES
  // -------------------------------
  function updateButtons() {
    const stepId = getCurrentStep();

    if (stepId === "step4") {
      nextBtn.style.display = "none";
      finishBtn.style.display = "inline-block";
      finishBtn.disabled = !validateStep(stepId);
    } else {
      nextBtn.style.display = "inline-block";
      finishBtn.style.display = "none";
      nextBtn.disabled = !validateStep(stepId);
    }
  }

  // -------------------------------
  // ATTACH EVENTS TO EVERY INPUT
  // -------------------------------
  Object.keys(stepFields).forEach(stepId => {

    stepFields[stepId].forEach(field => {

      let input =
        field === "terms"
          ? document.getElementById("terms")
          : document.getElementById(`property_${field}`);

      if (!input) return;

      input.addEventListener("input", function () {
        // alert(this.type === "checkbox" ? this.checked : this.value);
        updateButtons();
      });

      input.addEventListener("change", function () {
        // alert(this.type === "checkbox" ? this.checked : this.value);
        updateButtons();
      });

    });

  });

  // -------------------------------
  // REVALIDATE ON STEP CHANGE
  // -------------------------------
  document.querySelectorAll('[data-toggle="tab"]').forEach(tab => {
    tab.addEventListener("shown.bs.tab", function () {
      updateButtons();
    });
  });

  // -------------------------------
  // INITIAL STATE
  // -------------------------------
  updateButtons();




});