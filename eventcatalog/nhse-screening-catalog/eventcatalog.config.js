/** @type {import('@eventcatalog/core/bin/eventcatalog.config').Config} */
export default {
  cId: 'e56b5efd-7a73-4ee9-a522-b1aa313c1c5e',
  title: "Digital Screening Event Catalog",
  tagline: "Discover, Explore and Document your Event Driven Architectures",
  organizationName: "NHS England",
  homepageLink: "https://eventcatalog.dev/",
  editUrl: "https://github.com/boyney123/eventcatalog-demo/edit/master",
  // By default set to false, add true to get urls ending in /
  trailingSlash: false,
  // Change to make the base url of the site different, by default https://{website}.com/docs,
  // changing to /company would be https://{website}.com/company/docs,
  base: "/dtos-solution-architecture/eventcatalog",
  // Customize the logo, add your logo to public/ folder
  logo: {
    alt: "Digital Screening Event Catalog Logo",
    src: "/logo.png",
    text: "Digital Screening Event Catalog",
  },
  docs: {
    sidebar: {
      // Should the sub heading be rendered in the docs sidebar?
      showPageHeadings: true,
    },
  },
};
