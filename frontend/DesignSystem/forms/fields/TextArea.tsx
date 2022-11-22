import classNames from "classnames";
import React, { ChangeEvent, PropsWithChildren, useContext } from "react";
import { Field, FieldProps, FieldRenderProps } from "react-final-form";
import TextArea, { TextAreaProps } from "../inputs/TextArea";

export type InputFieldProps = FieldProps<string, FieldRenderProps<string>> &
  TextAreaProps & { maxChars?: number };

const TextAreaField = (props: PropsWithChildren<InputFieldProps>) => {
  return (
    <Field
      {...props}
      render={({ input, meta }) => {
        const invalid = meta.error && meta.touched && !meta.active;
        return (
          <div>
            <TextArea
              {...props}
              {...input}
              disabled={props.disabled}
              invalid={invalid}
              placeholder={props.placeholder}
              onChange={(e: ChangeEvent<HTMLTextAreaElement>) => {
                input.onChange(e);
                if (props.onChange) {
                  props.onChange(e);
                }
              }}
            />
            <div
              className={classNames(
                "flex items-center",
                invalid ? "justify-between" : "justify-end"
              )}
            >
              {props.maxChars && (
                <span className="text-gray-500 text-sm">
                  {input.value.length}/{props.maxChars} characters
                </span>
              )}
            </div>
          </div>
        );
      }}
    />
  );
};

export default TextAreaField;
