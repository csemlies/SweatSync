import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "duration", "startDt", "endDt"]

  slotClicked(event) {
    const startIso = event.currentTarget.dataset.start
    const durationMin = parseInt(this.durationTarget.value, 10)

    const start = new Date(startIso)
    const end = new Date(start.getTime() + durationMin * 60 * 1000)

    this.startDtTarget.value = start.toISOString()
    this.endDtTarget.value = end.toISOString()

    this.formTarget.requestSubmit()
  }
}
