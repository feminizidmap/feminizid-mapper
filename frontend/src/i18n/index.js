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
      categories: {
        title: "Categories",
        blurb: "Here is a blurb"
      },
      settings: "Settings",
      schema: "Data schema",
      userManagement: "User management",
      caselist: "Cases",
      adminArea: "Admin area",
      overview: "Overview",
      incomplete: "Incomplete"
    },
    admin: {
      system: 'System settings',
      users: {
        list: 'User management'
      }
    },
    models: {
      category: {
        name: "Category name",
        description: "Category description",
        slug: "Category slug",
        noSuch: "No such category"
      },
      categoryItem: {
        identifier: "Category option",
        name: "Option name",
        slug: "Option slug",
        description: "Option description",
        noSuch: "No Item",
      }
    },
    prompts: {
      signin: "Please sign in",
      signup: "Please sign up",
      forgotpassword: "Forgot your password?",
      resetpassword: "Choose a new password",
      newCategory: "Add a new category",
      newCategoryItem: "Add a new item to this category"
    },
    actions: {
      new: "Add",
      save: "Save"
    },
    notice: {
      singedOut: "Signed out, see you!",
      deleteCodelist: "Successfully deleted option list",
      deleteCodelistItem: "Successfully deleted option",
    },
    errors: {
      general: "Something went wrong",
      cannotSignout: "Cannot sign out"
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
      categories: {
        title: "Kategorien",
        blurb: "Kategorien sind Informationen mit vorher festgelegten Optionen."
      },
      settings: "Einstellungen",
      userManagement: "Usermanagement",
      caselist: "Fälle",
      admin: "Admin",
      schema: "Datenschema",
      overview: "Übersicht",
      incomplete: "Unvollständig"
    },
    admin: {
      system: 'Systemeinstellungen',
      users: {
        list: 'NutzerInnenverwaltung'
      }
    },
    models: {
      category: {
        name: "Name der Kategorie",
        description: "Beschreibung der Kategorie",
        slug: "Kategorie-Slug",
        noSuch: "Keine solche Kategorie"
      },
      categoryItem: {
        identifier: "Kategorie-Option",
        name: "Optionsname",
        slug: "Option-Slug",
        description: "Optionsbeschreibung",
        noSuch: "Keine Optionen",
      }
    },
    prompts: {
      signin: "Bitte melde dich an",
      signup: "Bitte registriere dich",
      forgotpassword: "Password vergessen?",
      resetpassword: "Wähle ein neues Password",
      newCategory: "Füge eine neue Kategorie hinzu",
      newCategoryItem: "Füge eine neues Element zur Kategorie hinzu"
    },
    actions: {
      new: "Hinzufügen",
      save: "Speichern"
    },
    notice: {
      singedOut: "Abgemeldet, bis bald!",
      deleteCodelist: "Optionsliste erfolgreich gelöscht",
      deleteCodelistItem: "Option erfolgreich gelöscht",
    },
    errors: {
      general: "Etwas is schief gelaufen",
      cannotSignout: "Abmelden nicht möglich"
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
