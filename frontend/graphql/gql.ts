/* eslint-disable */
import * as types from './graphql';
import { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';

const documents = {
    "\n  query account {\n    account(id: \"https://ruby.social/ryanbigg\") {\n      uri\n    }\n  }\n": types.AccountDocument,
    "\n  mutation postStatus($input: PostStatusInput!) {\n    postStatus(input: $input) {\n      id\n    }\n  }\n": types.PostStatusDocument,
    "\n  query getStatus($id: ID!) {\n    status(id: $id) {\n      id\n    }\n  }\n": types.GetStatusDocument,
    "\n  query timeline {\n    timeline {\n      id\n      content\n      account {\n        uri\n      }\n    }\n  }\n": types.TimelineDocument,
};

export function graphql(source: "\n  query account {\n    account(id: \"https://ruby.social/ryanbigg\") {\n      uri\n    }\n  }\n"): (typeof documents)["\n  query account {\n    account(id: \"https://ruby.social/ryanbigg\") {\n      uri\n    }\n  }\n"];
export function graphql(source: "\n  mutation postStatus($input: PostStatusInput!) {\n    postStatus(input: $input) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation postStatus($input: PostStatusInput!) {\n    postStatus(input: $input) {\n      id\n    }\n  }\n"];
export function graphql(source: "\n  query getStatus($id: ID!) {\n    status(id: $id) {\n      id\n    }\n  }\n"): (typeof documents)["\n  query getStatus($id: ID!) {\n    status(id: $id) {\n      id\n    }\n  }\n"];
export function graphql(source: "\n  query timeline {\n    timeline {\n      id\n      content\n      account {\n        uri\n      }\n    }\n  }\n"): (typeof documents)["\n  query timeline {\n    timeline {\n      id\n      content\n      account {\n        uri\n      }\n    }\n  }\n"];

export function graphql(source: string): unknown;
export function graphql(source: string) {
  return (documents as any)[source] ?? {};
}

export type DocumentType<TDocumentNode extends DocumentNode<any, any>> = TDocumentNode extends DocumentNode<  infer TType,  any>  ? TType  : never;