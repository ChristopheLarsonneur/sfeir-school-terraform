// One method per module
function schoolSlides() {
  return ['00-school-aws-tiny/00-TITLE.md', '00-school-aws-tiny/speaker-cla.md','00-school-aws-tiny/planning.md'];
}

function introSlides() {
  return ['01_intro-aws-tiny/00-TITLE.md'];
}

function premiersPasSlides() {
  return ['02_premiers_pas-aws-tiny/00-TITLE.md'];
}

function langagesSlides() {
  return ['03-Reading-tf-code-aws-tiny/00-TITLE.md'];
}

function configurationSlides() {
  return ['04_modules-aws-tiny/00-TITLE.md'];
}

function exerciceSlides() {
  return ['05_exercice-aws-tiny/00-TITLE.md'];
}

function formation() {
  return [
    //
    ...schoolSlides(),
    ...introSlides(),
    ...premiersPasSlides(),
    ...langagesSlides(),
    ...configurationSlides(),
    ...exerciceSlides()
  ].map(slidePath => {
    return {path: slidePath};
  });
}

export function usedSlides() {
  return formation();
}
