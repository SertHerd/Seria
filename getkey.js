const currentUrl = window.location.href;

const urlObject = new URL(currentUrl);

const hwid = urlObject.searchParams.get("hwid");

if (hwid) {
  console.log("hwid:", hwid);
} else {
  console.log("Thiếu tham số hwid");
}
