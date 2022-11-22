
import type { CodegenConfig } from '@graphql-codegen/cli';

const config: CodegenConfig = {
  overwrite: true,
  schema: "http://localhost:2300/graphql",
  documents: "components/**/*.ts{,x}",
  generates: {
    "graphql/": {
      preset: "client",
      plugins: [
        // 'typescript',
        // 'typescript-react-apollo',
        // 'typescript-operations',
      ]
    }
  }
};

export default config;
