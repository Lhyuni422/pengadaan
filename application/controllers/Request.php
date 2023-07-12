<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Supplier extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        cek_login();

        $this->load->model('Admin_model', 'admin');
        $this->load->library('form_validation');
    }

    public function index()
    {
        $data['title'] = "req_barang";
        $data['req_barang'] = $this->admin->get('req_barang');
        $this->template->load('templates/dashboard', 'req_barang/data', $data);
    }

    private function _validasi()
    {
        $this->form_validation->set_rules('nama_supplier', 'Nama Supplier', 'required|trim');
        $this->form_validation->set_rules('no_telp', 'Nomor Telepon', 'required|trim|numeric');
        $this->form_validation->set_rules('alamat', 'Alamat', 'required|trim');
    }

    public function add()
    {
        $this->_validasi();
        if ($this->form_validation->run() == false) {
            $data['title'] = "req_barang";
            $this->template->load('templates/dashboard', 'req_barang/add', $data);
        } else {
            $input = $this->input->post(null, true);
            $save = $this->admin->insert('req_barang', $input);
            if ($save) {
                set_pesan('data berhasil disimpan.');
                redirect('req_barang');
            } else {
                set_pesan('data gagal disimpan', false);
                redirect('req_barang/add');
            }
        }
    }


    public function edit($getId)
    {
        $id = encode_php_tags($getId);
        $this->_validasi();

        if ($this->form_validation->run() == false) {
            $data['title'] = "req_barang";
            $data['req_barang'] = $this->admin->get('req_barang', ['id_supplier' => $id]);
            $this->template->load('templates/dashboard', 'req_barang/edit', $data);
        } else {
            $input = $this->input->post(null, true);
            $update = $this->admin->update('req_barang', 'id_supplier', $id, $input);

            if ($update) {
                set_pesan('data berhasil diedit.');
                redirect('suppreq_baranglier');
            } else {
                set_pesan('data gagal diedit.');
                redirect('supplier/edit/' . $id);
            }
        }
    }

    public function delete($getId)
    {
        $id = encode_php_tags($getId);
        if ($this->admin->delete('req_barang', 'id_supplier', $id)) {
            set_pesan('data berhasil dihapus.');
        } else {
            set_pesan('data gagal dihapus.', false);
        }
        redirect('req_barang');
    }
}
