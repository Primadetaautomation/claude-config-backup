import { defineConfig, devices } from '@playwright/test';

/**
 * CPU-OPTIMIZED PLAYWRIGHT CONFIG
 * Minimaal CPU-gebruik voor lokale development
 */

const isCI = !!process.env.CI;
const runAllBrowsers = !!process.env.PW_ALL_BROWSERS;

export default defineConfig({
  // KRITIEK: Minimaal aantal workers voor CPU-besparing
  workers: isCI ? 2 : 1, // Lokaal: 1 worker = minimale CPU stress

  // Sequentieel uitvoeren = minder context-switches
  fullyParallel: false,

  // Geen retries lokaal voor snelle feedback
  retries: isCI ? 1 : 0,

  // Minimale reporter lokaal
  reporter: isCI
    ? [['list'], ['html', { outputFolder: 'playwright-report', open: 'never' }]]
    : [['line']], // 'line' is lichter dan 'list'

  // Resource-besparende standaardinstellingen
  use: {
    // Headless = geen GPU gebruik
    headless: true,

    // BELANGRIJK: Alle media uit voor CPU-besparing
    video: 'off',
    screenshot: 'off',
    trace: 'off', // Alleen aan bij debugging

    // Kleiner viewport = minder rendering
    viewport: { width: 1024, height: 768 },

    // Aggressive browser optimalisaties
    launchOptions: {
      args: [
        '--disable-dev-shm-usage',
        '--disable-gpu',                  // GPU uit
        '--disable-web-security',          // Sneller laden
        '--disable-features=VizDisplayCompositor',
        '--disable-breakpad',
        '--disable-background-networking',
        '--disable-background-timer-throttling',
        '--disable-backgrounding-occluded-windows',
        '--disable-component-extensions-with-background-pages',
        '--disable-extensions',
        '--disable-features=TranslateUI',
        '--disable-ipc-flooding-protection',
        '--disable-renderer-backgrounding',
        '--no-sandbox',                    // Sneller opstarten (alleen lokaal!)
        '--disable-setuid-sandbox',
        '--disable-dev-profile',
        '--no-first-run',
        '--no-zygote',
        '--single-process',                // Alles in 1 proces (experimenteel maar snel)
        '--memory-pressure-off',
        '--max-old-space-size=256',        // Beperk geheugen per tab
      ],
      // Nog meer Chrome flags voor minimale footprint
      ignoreDefaultArgs: ['--enable-automation'],
    },

    // Snellere page loads
    bypassCSP: true,
    ignoreHTTPSErrors: true,

    // Base URL voor preview server
    baseURL: 'http://localhost:4173',

    // Korte action timeout
    actionTimeout: 10_000,
    navigationTimeout: 15_000,
  },

  // Preview server i.p.v. dev server (geen hot reload = rust)
  webServer: {
    command: 'npm run preview',
    url: 'http://localhost:4173',
    reuseExistingServer: !isCI,
    timeout: 30_000,
    stdout: 'ignore',
    stderr: 'pipe',
  },

  // Test configuratie
  testDir: 'tests',
  testMatch: '**/*.spec.{js,ts}',

  // Korte timeouts voor snelle feedback
  timeout: 20_000,
  expect: {
    timeout: 3_000,
    toHaveScreenshot: {
      maxDiffPixels: 100,
      animations: 'disabled',
    },
  },

  // Minimal browser setup - standaard alleen Chromium
  projects: runAllBrowsers
    ? [
        {
          name: 'chromium',
          use: {
            ...devices['Desktop Chrome'],
            // Extra optimalisaties per browser
            contextOptions: {
              reducedMotion: 'reduce',
              forcedColors: 'none',
            },
          },
        },
        // Firefox en WebKit alleen als expliciet gevraagd
        { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
        { name: 'webkit', use: { ...devices['Desktop Safari'] } },
      ]
    : [
        {
          name: 'chromium',
          use: {
            ...devices['Desktop Chrome'],
            contextOptions: {
              reducedMotion: 'reduce',
              forcedColors: 'none',
            },
          },
        },
      ],

  // Output configuratie
  outputDir: 'test-results',

  // Globale setup/teardown
  globalSetup: undefined, // Alleen als nodig
  globalTeardown: undefined,

  // Verbosity voor debugging (zet op true indien nodig)
  quiet: !isCI,

  // Fail fast optie - stop bij eerste failure
  maxFailures: isCI ? 0 : 1,
});