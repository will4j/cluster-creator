package main

ociRepoCRD: {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		labels: {
			"app.kubernetes.io/component":           "source-controller"
			"app.kubernetes.io/instance":            "flux-system"
			"app.kubernetes.io/part-of":             "flux"			
			"kustomize.toolkit.fluxcd.io/name":      "flux-system"
			"kustomize.toolkit.fluxcd.io/namespace": "flux-system"
		}
		name: "ocirepositories.source.toolkit.fluxcd.io"
	}
	spec: {
		conversion: strategy: "None"
		group: "source.toolkit.fluxcd.io"
		names: {
			kind:     "OCIRepository"
			listKind: "OCIRepositoryList"
			plural:   "ocirepositories"
			shortNames: [
				"ocirepo",
			]
			singular: "ocirepository"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.url"
				name:     "URL"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "OCIRepository is the Schema for the ocirepositories API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "OCIRepositorySpec defines the desired state of OCIRepository"
						properties: {
							certSecretRef: {
								description: """
		CertSecretRef can be given the name of a secret containing either or both of 
		 - a PEM-encoded client certificate (`certFile`) and private key (`keyFile`); - a PEM-encoded CA certificate (`caFile`) 
		 and whichever are supplied, will be used for connecting to the registry. The client cert and key are useful if you are authenticating with a certificate; the CA cert is useful if you are using a self-signed server certificate.
		"""

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: [
									"name",
								]
								type: "object"
							}
							ignore: {
								description: "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."

								type: "string"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS HTTP container registry."

								type: "boolean"
							}
							interval: {
								description: "The interval at which to check for image updates."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:        "string"
							}
							layerSelector: {
								description: "LayerSelector specifies which layer should be extracted from the OCI artifact. When not specified, the first layer found in the artifact is selected."

								properties: {
									mediaType: {
										description: "MediaType specifies the OCI media type of the layer which should be extracted from the OCI Artifact. The first layer matching this type is selected."

										type: "string"
									}
									operation: {
										description: "Operation specifies how the selected layer should be processed. By default, the layer compressed content is extracted to storage. When the operation is set to 'copy', the layer compressed content is persisted to storage as it is."

										enum: [
											"extract",
											"copy",
										]
										type: "string"
									}
								}
								type: "object"
							}
							provider: {
								default:     "generic"
								description: "The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'. When not specified, defaults to 'generic'."

								enum: [
									"generic",
									"aws",
									"azure",
									"gcp",
								]
								type: "string"
							}
							ref: {
								description: "The OCI reference to pull and monitor for changes, defaults to the latest tag."

								properties: {
									digest: {
										description: "Digest is the image digest to pull, takes precedence over SemVer. The value should be in the format 'sha256:<HASH>'."

										type: "string"
									}
									semver: {
										description: "SemVer is the range of tags to pull selecting the latest within the range, takes precedence over Tag."

										type: "string"
									}
									tag: {
										description: "Tag is the image tag to pull, defaults to latest."
										type:        "string"
									}
								}
								type: "object"
							}
							secretRef: {
								description: "SecretRef contains the secret name containing the registry login credentials to resolve image metadata. The secret must be of type kubernetes.io/dockerconfigjson."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: [
									"name",
								]
								type: "object"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate the image pull if the service account has attached pull secrets. For more information: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account"

								type: "string"
							}
							suspend: {
								description: "This flag tells the controller to suspend the reconciliation of this source."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "The timeout for remote OCI Repository operations like pulling, defaults to 60s."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:    "string"
							}
							url: {
								description: "URL is a reference to an OCI artifact repository hosted on a remote container registry."

								pattern: "^oci://.*$"
								type:    "string"
							}
							verify: {
								description: "Verify contains the secret name containing the trusted public keys used to verify the signature and specifies which provider to use to check whether OCI image is authentic."

								properties: {
									provider: {
										default:     "cosign"
										description: "Provider specifies the technology used to sign the OCI Artifact."

										enum: [
											"cosign",
										]
										type: "string"
									}
									secretRef: {
										description: "SecretRef specifies the Kubernetes Secret containing the trusted public keys."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: [
											"name",
										]
										type: "object"
									}
								}
								required: [
									"provider",
								]
								type: "object"
							}
						}
						required: [
							"interval",
							"url",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "OCIRepositoryStatus defines the observed state of OCIRepository"
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful OCI Repository sync."

								properties: {
									checksum: {
										description: "Checksum is the SHA256 checksum of the Artifact file."
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

										format: "date-time"
										type:   "string"
									}
									metadata: {
										additionalProperties: type: "string"
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
									}
									path: {
										description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

										type: "string"
									}
									revision: {
										description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										format:      "int64"
										type:        "integer"
									}
									url: {
										description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

										type: "string"
									}
								}
								required: [
									"path",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the OCIRepository."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							contentConfigChecksum: {
								description: """
		ContentConfigChecksum is a checksum of all the configurations related to the content of the source artifact: - .spec.ignore - .spec.layerSelector observed in .status.observedGeneration version of the object. This can be used to determine if the content configuration has changed and the artifact needs to be rebuilt. It has the format of `<algo>:<checksum>`, for example: `sha256:<checksum>`. 
		 Deprecated: Replaced with explicit fields for observed artifact content config in the status.
		"""

								type: "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							observedIgnore: {
								description: "ObservedIgnore is the observed exclusion patterns used for constructing the source artifact."

								type: "string"
							}
							observedLayerSelector: {
								description: "ObservedLayerSelector is the observed layer selector used for constructing the source artifact."

								properties: {
									mediaType: {
										description: "MediaType specifies the OCI media type of the layer which should be extracted from the OCI Artifact. The first layer matching this type is selected."

										type: "string"
									}
									operation: {
										description: "Operation specifies how the selected layer should be processed. By default, the layer compressed content is extracted to storage. When the operation is set to 'copy', the layer compressed content is persisted to storage as it is."

										enum: [
											"extract",
											"copy",
										]
										type: "string"
									}
								}
								type: "object"
							}
							url: {
								description: "URL is the download link for the artifact output of the last OCI Repository sync."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
