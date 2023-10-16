import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal", "phoneNumber"];

  connect() {}

  showPhoneNumber() {
    const phoneNumberElement = document.getElementById("phoneNumber");
    const phoneNumber = this.element.getAttribute("data-phone-number");
    if(phoneNumberElement){
      phoneNumberElement.textContent=phoneNumber;
    }
    $('#phoneModal').modal('show') 
    this.hideModal();
   }
   hideModal(){
    $('#closeModal').click(function(){
    $('#phoneModal').modal('hide') 

    })
     $('#close-Modal').click(function(){
      $('#phoneModal').modal('hide') 

    })
  }
}
