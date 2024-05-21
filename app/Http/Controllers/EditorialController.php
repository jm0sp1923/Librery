<?php

namespace App\Http\Controllers;

use App\Models\Editorial;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class EditorialController extends Controller
{

    private $rules = [
        'name' => 'required|string|max:50|min:3',
        'address' => 'string|max:80|min:3'
    ];

    private $traductionAttributes = [
        'name' => 'nombre',
        'address' => 'dorección'
    ];

    public function applyValidator(Request $request)
    {
        $validator = Validator::make($request->all(), $this->rules);
        $validator->setAttributeNames($this->traductionAttributes);
        $data = [];

        if ($validator->fails()) {
            $data = response()->json(
                [
                    'errors' => $validator->errors(),
                    'data' => $request->all()
                ],
                Response::HTTP_BAD_REQUEST
            );
        }

        return $data;
    }

    public function index()
    {
        $editorials = Editorial::all();

        return response()->json($editorials, Response::HTTP_OK);
    }


    public function store(Request $request)
    {
        $data = $this->applyValidator($request);
        if(!empty($data)){
            return $data;
        }

        $editorial = Editorial::create($request->all());

        $response = [
            'Message' => "registro creado exitosamente",
            'editorial' => $editorial
        ];
        
        return response()->json($response, Response::HTTP_CREATED);
    }
    
   
    public function show(Editorial $editorial)
    {
        return response()->json($editorial, Response::HTTP_OK);
    }

    
    public function update(Request $request, Editorial $editorial)
    {
        $data = $this->applyValidator($request);
        if(!empty($data)){
            return $data;
        }

        $editorial->update($request->all());

        $response = [
            'Message' => "registro actualizado exitosamente",
            'editorial' => $editorial
        ];
        
        return response()->json($response, Response::HTTP_OK);
    }

   
    public function destroy(Editorial $editorial)
    {
        $editorial->delete();
        $response = [
            'Message' => "registro eliminado exitosamente",
            'editorial' => $editorial->id
        ];
        return response()->json($response, Response::HTTP_OK);
    }
}
