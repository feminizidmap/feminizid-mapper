export function slugify(string) {
  if (!string) return ''
  return string.toLowerCase()
    .replaceAll(" ", "-")
    .replaceAll("ä", "ae")
    .replaceAll("ö", "oe")
    .replaceAll("ü", "ue")
    .replaceAll("ß", "ss")
    .replaceAll('"', "")
    .replaceAll("'", "")
}
