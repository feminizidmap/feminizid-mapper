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
      delete: "Delete",
      create: "Add",
      cancel: "Cancel",
      close: "Close"
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
      caselist: "Cases",
      admin: "Admin",
      overview: "Overview",
      incomplete: "Incomplete"
    },
    models: {
      codelist: {
        name: "Option list name",
        description: "Option list description",
        lang: "Language of option list",
        noSuch: "No such list",
      },
      codelistItem: {
        identifier: "Code",
        name: "Option name",
        description: "Option description",
        lang: "Language of option",
        noSuch: "No options",
      }
    },
    prompts: {
      signin: "Please sign in",
      signup: "Please sign up",
      forgotpassword: "Forgot your password?",
      resetpassword: "Choose a new password",
      newOption: "Add a new option to this list",
      newCodelist: "Add a new option list"
    },
    notice: {
      singedOut: "Signed out, see you!",
      deleteCodelist: "Successfully deleted option list",
      deleteCodelistItem: "Successfully deleted option",
    },
    errors: {
      general: "Something went wrong",
      cannotSignout: "Cannot sign out",
      cannotCreateCodelist: "Cannot create option list",
      cannotDeleteCodelist: "Cannot delete option list",
      cannotUpdateCodelist: "Cannot update option list",
      cannotDeleteCodelistItem: "Cannot delete option",
      cannotUpdateCodelistItem: "Cannot update option",
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
      delete: "Löschen",
      create: "Hinzufügen",
      cancel: "Abbrechen",
      close: "Schließen"
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
      caselist: "Fälle",
      admin: "Admin",
      overview: "Übersicht",
      incomplete: "Unvollständig"
    },
    models: {
      codelist: {
        name: "Name der Optionsliste",
        description: "Beschreibung der Optionsliste",
        lang: "Sprache der Optionsliste",
        noSuch: "Keine solche Liste"
      },
      codelistItem: {
        identifier: "Code",
        name: "Optionsname",
        description: "Optionsbeschreibung",
        lang: "Sprache der Option",
        noSuch: "Keine Optionen",
      }
    },
    prompts: {
      signin: "Bitte melde dich an",
      signup: "Bitte registriere dich",
      forgotpassword: "Password vergessen?",
      resetpassword: "Wähle ein neues Password",
      newOption: "Füge eine neue Option zu dieser Liste hinzu",
      newCodelist: "Füge eine neue Optionsliste hinzu"
    },
    notice: {
      singedOut: "Abgemeldet, bis bald!",
      deleteCodelist: "Optionsliste erfolgreich gelöscht",
      deleteCodelistItem: "Option erfolgreich gelöscht",
    },
    errors: {
      general: "Etwas is schief gelaufen",
      cannotSignout: "Abmelden nicht möglich",
      cannotDeleteCodelist: "Optionsliste konnte nicht gelöscht werden",
      cannotUpdateCodelist: "Optionsliste konnte nicht bearbeitet werden",
      cannotDeleteCodelistItem: "Option konnte nicht gelöscht werden",
      cannotUpdateCodelistItem: "Option konnte nicht bearbeitet werden"
    }
  }
}


const i18n = createI18n({
  locale: 'de',
  fallbackLocale: 'en',
  availableLocales: ['en', 'de'],
  messages
})

export { i18n }
