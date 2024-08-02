import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["accountDetail"];

  connect() {
    this.accountDetailTarget.style.display = "none";
    this.debounceTimeout = null;
    this.accountDetailTarget.innerText = "";
    this.accountValid = false;
  }

  inputAccountId(e) {
    clearTimeout(this.debounceTimeout);
    const accountId = e.target.value;

    this.debounceTimeout = setTimeout(() => {
      this.fetchAccount(accountId);
    }, 300);
  }

  async fetchAccount(id) {
    if (!id) {
      this.accountDetailTarget.style.display = "none";
      this.accountDetailTarget.innerText = "";
      return;
    }

    try {
      const response = await fetch(`/accounts/${id}.json`);
      if (!response.ok) {
        throw new Error("Account not found");
      }

      const data = await response.json();
      this.accountDetailTarget.innerText = `Account Owner: ${data.full_name}`;
      this.accountDetailTarget.style.display = "block";
      this.accountDetailTarget.classList.remove("invalid-feedback");
      this.accountDetailTarget.classList.add("text-success");
      this.accountValid = true;
    } catch (error) {
      this.accountDetailTarget.innerText = "Account not found";
      this.accountDetailTarget.style.display = "block";
      this.accountDetailTarget.classList.add("invalid-feedback");
      this.accountDetailTarget.classList.remove("text-success");
      this.accountValid = false;
    }
  }
}
// TODO: How to add locals to this part?
