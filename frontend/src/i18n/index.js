import { createI18n } from 'vue-i18n'

const messages = {
  en: {
    forms: {
      email: "Email address",
      password: "Password",
      newPassword: "New password",
      passwordConfirmation: "Password confirmation",
      signIn: "Sign in",
      signUp: "Sign up",
      forgotPassword: "Forgot password",
      resetPassword: "Reset password",
      changeLang: "Change language",
      save: "Save",
      edit: "Edit",
      delete: "Delete"
    },
    dashboard: {
      title: "Dashboard"
    },
    resetPassword: {
      mailSent: "Email with passwort reset instructions has been sent.",
      resetSuccessful: "Your password has been reset successfully! Please sign in with your new password."
    },
    layout: {
      totop: "to top",
      cases: "Cases",
      codelist: "Option lists",
      settings: "Settings",
      userManagement: "User management",
      admin: "Admin",
    },
    models: {
      codelist: {
        name: "Option list name",
        description: "Option list description",
        noSuch: "No such list",
      }
    },
    prompts: {
      signin: "Please sign in",
      signup: "Please sign up",
      forgotpassword: "Forgot your password?",
      resetpassword: "Choose a new password"
    },
    notice: {
      singedOut: "Signed out, see you!",
      deleteCodelist: "Successfully deleted option list",
    },
    errors: {
      general: "Something went wrong",
      cannotSignout: "Cannot sign out",
      cannotDeleteCodelist: "Cannot delete option list",
      cannotUpdateCodelist: "Cannot update option list"
    }
  },
  de: {
    forms: {
      email: "Email-Addresse",
      password: "Passwort",
      newPassword: "Neues Passwort",
      passwordConfirmation: "Passwort bestätigen",
      signIn: "Anmelden",
      signUp: "Registrieren",
      forgotPassword: "Passwort vergessen",
      resetPassword: "Passwort zurücksetzen",
      changeLang: "Sprache wechseln",
      save: "Speichern",
      edit: "Bearbeiten",
      delete: "Löschen"
    },
    dashboard: {
      title: "Dashboard"
    },
    resetPassword: {
      mailSent: "Anleitung zum Passwortzurücksetzen per Email verschickt.",
      resetSuccessful: "Dein Passwort wurde erfolgreich zurückgesetzt! Bitte melde dich mit deinem neuen Passwort an."
    },
    layout: {
      totop: "nach oben",
      cases: "Fälle",
      codelist: "Optionslisten",
      settings: "Einstellungen",
      userManagement: "Usermanagement",
      admin: "Admin"
    },
    models: {
      codelist: {
        name: "Name der Optionsliste",
        description: "Beschreibung der Optionsliste",
        noSuch: "Keine solche Liste"
      }
    },
    prompts: {
      signin: "Bitte melde dich an",
      signup: "Bitte registriere dich",
      forgotpassword: "Password vergessen?",
      resetpassword: "Wähle ein neues Password"
    },
    notice: {
      singedOut: "Abgemeldet, bis bald!",
      deleteCodelist: "Optionsliste erfolgreich gelöscht",
    },
    errors: {
      general: "Etwas is schief gelaufen",
      cannotSignout: "Abmelden nicht möglich",
      cannotDeleteCodelist: "Optionsliste konnte nicht gelöscht werden",
      cannotUpdateCodelist: "Optionsliste konnte nicht bearbeitet werden"
    }
  }
}


const i18n = createI18n({
  locale: 'en',
  fallbackLocale: 'en',
  availableLocales: ['en', 'de'],
  messages
})

export { i18n }
