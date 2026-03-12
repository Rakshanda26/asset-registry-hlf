package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type SmartContract struct {
	contractapi.Contract
}

type Asset struct {
	AssetID string `json:"assetID"`
	Owner   string `json:"owner"`
	Type    string `json:"type"`
	Value   int    `json:"value"`
}

func (s *SmartContract) RegisterAsset(
	ctx contractapi.TransactionContextInterface,
	assetID string,
	owner string,
	assetType string,
	value int,
) error {

	// TODO: Implement asset registration logic

	return nil
}

func (s *SmartContract) GetAsset(
	ctx contractapi.TransactionContextInterface,
	assetID string,
) (*Asset, error) {

	// TODO: Implement asset retrieval logic

	return nil, nil
}

func main() {

	chaincode, err := contractapi.NewChaincode(&SmartContract{})
	if err != nil {
		panic(fmt.Sprintf("Error creating chaincode: %v", err))
	}

	if err := chaincode.Start(); err != nil {
		panic(fmt.Sprintf("Error starting chaincode: %v", err))
	}
}
