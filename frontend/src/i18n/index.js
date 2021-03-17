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
    }
  }
}


const i18n = createI18n({
  locale: 'en',
  fallbackLocale: 'en',
  messages
})

export { i18n }
