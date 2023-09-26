// Import Stimulus
import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    const imageUpload = this.element.querySelector("#image-upload");
    const imagePreviewContainer = this.element.querySelector("#image-preview-container");
    const submitButton = this.element.querySelector("#submit-button");

    imageUpload.addEventListener("change", () => {
      imagePreviewContainer.innerHTML = "";

      const files = Array.from(imageUpload.files);
      const maxImages = 5;

      if (files.length > maxImages) {
        $(imageLimitModal).modal("show");
        this.hideModal();
        imageUpload.value = "";
        submitButton.disabled = true;
        return;
      }
      files.forEach((file) => {
        const reader = new FileReader();
        reader.onload = (e) => {
          const imagePreview = document.createElement("div");
          imagePreview.classList.add("image-preview-item");
          imagePreview.innerHTML = `
            <img src="${e.target.result}" alt="Selected Image">
            <span class="remove-image" data-file="${file.name}">&times;</span>
          `;
          imagePreviewContainer.appendChild(imagePreview);
        };
        reader.readAsDataURL(file);
      });

      submitButton.disabled = false;
    });

    imagePreviewContainer.addEventListener("click", (e) => {
      if (e.target.classList.contains("remove-image")) {
        const fileName = e.target.getAttribute("data-file");
        const files = Array.from(imageUpload.files);
        const updatedFiles = files.filter((file) => file.name !== fileName);

        if (updatedFiles.length === 0) {
          submitButton.disabled = true;
        }
        const newFileList = new DataTransfer();
        updatedFiles.forEach((file) => {
          newFileList.items.add(file);
        });

        imageUpload.files = newFileList.files;

        e.target.parentElement.remove();
      }
    });
  }

  hideModal(){
    $('#closeModal').click(function(){
    $('#imageLimitModal').modal('hide') 

    })
     $('#close-Modal').click(function(){
      $('#imageLimitModal').modal('hide') 

    })
  }

}
