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
      changes2Save: "There are local changes that need to be saved",
      cases: "Cases",
      categories: {
        title: "Categories",
        blurb: "Here is a blurb"
      },
      settings: "Settings",
      schema: {
        title: "Data schema",
        blurb: "The schema defines the structure of the data, that means the possible fields on a single record. Think of it as the columns in a spreadsheet.",
        record: {
          title: "Record",
          blurb: "Record is a single datum, one entry in your database. Everything starts here."
        },
        entity: {
          title: "Entity",
          blurb: "Entities group logical information together. They describe one 'thing'."
        }
      },
      userManagement: "User management",
      caselist: "Cases",
      adminArea: "Admin area",
      overview: "Overview",
      incomplete: "Incomplete"
    },
    admin: {
      system: {
        title: 'System settings',
        blurb: 'Here is an overview of all system wide settings'
      },
      users: {
        list: 'User management'
      }
    },
    models: {
      category: {
        name: "Category name",
        single: "Category",
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
      },
      entity: {
        name: "Entity name",
        slug: "Entity slug"
      },
      field: {
        name: "Field name",
        single: "Field",
        key: "Field slug",
        feature: "Extra feature",
        none: "- None - ",
        noSuch: "No fields"
      },
      attribute: {
        title: "Kategorie"
      }
    },
    prompts: {
      signin: "Please sign in",
      signup: "Please sign up",
      forgotpassword: "Forgot your password?",
      resetpassword: "Choose a new password",
      newCategory: "Add a new category",
      newCategoryItem: "Add a new item to this category",
      newEntity: "Add a new entity",
      newField: "Add a new field",
      addCategory: "Add a category",
      newFieldOrAttribute: "Add a field or category"
    },
    actions: {
      new: "Add",
      save: "Save",
      loading: "Loading..."
    },
    notice: {
      singedOut: "Signed out, see you!",
      deleteCodelist: "Successfully deleted option list",
      deleteCodelistItem: "Successfully deleted option",
      schemaSet: "Schema successfully saved",
      schemaNotSet: "Schema could not be saved"
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
      changes2Save: "There are local changes that need to be saved",
      cases: "Fälle",
      categories: {
        title: "Kategorien",
        blurb: "Kategorien sind Informationen mit vorher festgelegten Optionen."
      },
      settings: "Einstellungen",
      userManagement: "Usermanagement",
      caselist: "Fälle",
      admin: "Admin",
      schema: {
        title: "Datenschema",
        blurb: "Das Schema beschreibt die Datenstruktur, das heißt die möglichen Felder und Eigenschaften eines einzigen Eintrags. Stell sie dir wie die Spalten einer Tabelle vor.",
        record: {
          title: "Akte",
          blurb: "Eine Akte ist ein alleinstehendes Datum, ein Eintrag in der Datenbank. Alles geht von hier aus."
        },
        entity: {
          title: "Einheit",
          blurb: "Einheiten gruppieren logische Informationen zusammen. Sie beschreiben eine 'Sache'."
        }
      },
      overview: "Übersicht",
      incomplete: "Unvollständig"
    },
    admin: {
      system: {
        title: 'Systemeinstellungen',
        blurb: 'Hier ist die Übersicht über systemweite Einstellungen'
      },
      users: {
        list: 'NutzerInnenverwaltung'
      }
    },
    models: {
      category: {
        name: "Name der Kategorie",
        single: "Kategorie",
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
      },
      entity: {
        name: "Name der Einheit",
        slug: "Slug für die Einheit"
      },
      field: {
        name: "Feldname",
        single: "Feld",
        key: "Feld-Slug",
        feature: "Extra Feature",
        none: "- Keins - ",
        noSuch: "Keine Felder"
      }
    },
    prompts: {
      signin: "Bitte melde dich an",
      signup: "Bitte registriere dich",
      forgotpassword: "Password vergessen?",
      resetpassword: "Wähle ein neues Password",
      newCategory: "Füge eine neue Kategorie hinzu",
      newCategoryItem: "Füge eine neue Option zur Kategorie hinzu",
      newEntity: "Füge eine neue Einheit hinzu",
      newField: "Füge ein weiteres Feld hinzu",
      addCategory: "Füge eine Kategorie hinzu",
      newFieldOrAttribute: "Füge ein Feld oder eine Kategorie hinzu"
    },
    actions: {
      new: "Hinzufügen",
      save: "Speichern",
      loading: "Laden..."
    },
    notice: {
      singedOut: "Abgemeldet, bis bald!",
      deleteCodelist: "Optionsliste erfolgreich gelöscht",
      deleteCodelistItem: "Option erfolgreich gelöscht",
      schemaSet: "Datenschema erfolgreich gespeichert",
      schemaNotSet: "Datenschema konnte nicht gespeichert werden"
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
