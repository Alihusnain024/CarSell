import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["taskInput", "taskList"];
  static values = { lists: Array }

  connect() {
    this.listValues = JSON.parse(this.data.get("lists"));
    this.displayList();
  }

  displayList() {
    const listContainer = this.taskListTarget;
    listContainer.innerHTML = "";
    this.listValues.forEach((listItem) => {
      const taskItem = document.createElement("li");
      taskItem.textContent = listItem;
      listContainer.appendChild(taskItem);
    });
  }
}
