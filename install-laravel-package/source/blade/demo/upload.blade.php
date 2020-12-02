@extends('demo.layout')

@section('title', 'GCS Demo Page')

@section('body')
<div class="container-fluid">
    <div class="m-2" class="row justify-content-center">
        <form method="post" action="/demo/store" enctype="multipart/form-data">
            @csrf
            <div class="form-group">
                <label for="uploadImage">Choose Image</label>
                <input id="uploadImage" class="form-control" type="file" name="uploadImage">
            </div>
            <button type="submit" class="btn btn-dark d-block w-75 mx-auto">Upload</button>
        </form>
    </div>
</div>
@endsection