import { useMutation } from "@apollo/client";
import React from "react";
import { Form } from "react-final-form";
import PrimaryButton from "../../DesignSystem/buttons/PrimaryButton";
import TextAreaField from "../../DesignSystem/forms/fields/TextArea";
import { graphql } from "../../graphql";

type FormValues = {
  content: string;
};

const postStatusMutation = graphql(`
  mutation postStatus($input: PostStatusInput!) {
    postStatus(input: $input) {
      id
    }
  }
`);

export default function StatusForm() {
  const [postStatus] = useMutation(postStatusMutation, {
    refetchQueries: ["timeline"],
  });
  const onSubmit = (values: FormValues) => {
    postStatus({ variables: { input: values } });
  };

  return (
    <>
      <Form
        onSubmit={onSubmit}
        render={({ handleSubmit }) => {
          return (
            <form onSubmit={handleSubmit}>
              <label className="block mb-2">What's happening?</label>
              <TextAreaField name="content" className="mb-4" />
              <PrimaryButton type="submit">Post</PrimaryButton>
            </form>
          );
        }}
      />
    </>
  );
}
