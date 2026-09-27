/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        ink: {
          DEFAULT: '#12141C',
          50: '#F4F5F7',
          100: '#E4E6EC',
          200: '#C7CBD6',
          300: '#9BA1B3',
          400: '#6B7280',
          500: '#454B5C',
          600: '#2E3342',
          700: '#1F2330',
          800: '#171A24',
          900: '#12141C',
        },
        paper: '#F8F6F1',
        signal: {
          DEFAULT: '#C88A2E',
          50: '#FBF3E6',
          100: '#F5E3C2',
          300: '#E0B36B',
          500: '#C88A2E',
          600: '#A66E1E',
          700: '#7E5217',
        },
        momentum: {
          DEFAULT: '#0F8A7A',
          50: '#E4F5F2',
          100: '#BFE9E1',
          300: '#5FBFAD',
          500: '#0F8A7A',
          600: '#0B6B5F',
        },
        alert: {
          DEFAULT: '#B5473C',
          50: '#FBEAE8',
          300: '#DE8E85',
          500: '#B5473C',
        },
      },
      fontFamily: {
        display: ['"Sora"', 'system-ui', 'sans-serif'],
        body: ['"Inter"', 'system-ui', 'sans-serif'],
      },
      boxShadow: {
        hairline: '0 0 0 1px rgba(18,20,28,0.08)',
      },
    },
  },
  plugins: [],
};
