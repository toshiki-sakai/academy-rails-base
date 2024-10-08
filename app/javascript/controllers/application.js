import { Application } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails"; // Turboをインポート

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

Turbo.session.drive = true; // Turbo Driveを有効化

export { application };
