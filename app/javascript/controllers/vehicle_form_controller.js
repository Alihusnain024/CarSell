
import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.imageUpload = this.element.querySelector('.image-upload');
    this.imagePreview = document.getElementById('image-preview');
    this.removeImage = document.querySelector('.remove-image');
    this.submitButton = document.querySelector('#submit-button');

    this.imageUpload.addEventListener('change', this.onImageChange.bind(this));
    this.removeImage.addEventListener('click', this.onRemoveImage.bind(this));
  }

  onImageChange() {
    if (this.imageUpload.files && this.imageUpload.files[0]) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imagePreview.src = e.target.result;
        this.imagePreview.style.display = 'block';
        this.removeImage.style.display = 'block';
        this.submitButton.disabled = false;
      };
      reader.readAsDataURL(this.imageUpload.files[0]);
    } else {
      // Handle the case when the user cancels the image selection
      this.imagePreview.style.display = 'none';
      this.removeImage.style.display = 'none';
      this.submitButton.disabled = true;
    }
  }

  onRemoveImage() {
    this.imagePreview.style.display = 'none';
    this.removeImage.style.display = 'none';
    this.imageUpload.value = ''; // Clear the file input
    this.submitButton.disabled = true;
  }

  onSubmit(event) {
    if (!this.imageUpload.files.length) {
      event.preventDefault();
      alert('Please select an image before submitting.');
    }
  }
}
