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
      changeLang: "Change language"
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
      admin: "Admin"
    },
    prompts: {
      signin: "Please sign in",
      signup: "Please sign up",
      forgotpassword: "Forgot your password?",
      resetpassword: "Choose a new password"
    },
    notice: {
      singedOut: "Signed out, see you!"
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
      changeLang: "Sprache wechseln"
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
    prompts: {
      signin: "Bitte melde dich an",
      signup: "Bitte registriere dich",
      forgotpassword: "Password vergessen?",
      resetpassword: "Wähle ein neues Password"
    },
    notice: {
      singedOut: "Abgemeldet, bis bald!"
    },
    errors: {
      general: "Etwas is schief gelaufen",
      cannotSignout: "Abmelden nicht möglich"
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
